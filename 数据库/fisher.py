from flask import Flask, request, make_response, jsonify
import requests
import hashlib
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import Column, String, Integer, ForeignKey, Date, Text, Boolean, true,false
from sqlalchemy import and_, or_
import cymysql
import json
from datetime import datetime



app = Flask(__name__)
app.config.from_object('config')
app.config["SQLALCHEMY_DATABASE_URI"] = "mysql+cymysql://root:skeyjaneXLZ110@localhost:3306/fisher"
app.config['SQLALCHEMY_COMMIT_ON_TEARDOWN'] = True
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
db = SQLAlchemy(app)


#用户信息表
class UserInformation(db.Model):
    open_id = db.Column(String(50),primary_key=True,nullable=False)
    session_id = db.Column(String(50),nullable=False)
    #学校信息
    university = db.Column(String(20))
    college = db.Column(String(20))
    major = db.Column(String(20))
    grade = db.Column(String(10))
    degree = db.Column(String(5))
    #个人信息
    name = db.Column(String(20))
    gender = db.Column(String(5))
    PersonalWeb = db.Column(String(30))
    introduction = db.Column(Text)





#帖子表，每一个实例对应一篇帖子
class PostLibrary(db.Model):
    id = db.Column(Integer, primary_key=True,autoincrement=True)   #给每篇文章自动编个号
    theme = db.Column(String(10))          #帖子的主题，在写的时候确定，决定改帖子属于哪一个板块
    session_id = db.Column(String(50))    #作者的session_id
    name = db.Column(String(20))        #作者的名字
    title = db.Column(String(20))          #文章标题
    summary = db.Column(String(70))   #摘要指文章的前70个字
    article = db.Column(Text)
    zan_count = db.Column(Integer,default=0)   #用于统计该文章点赞数
    comment_count = db.Column(Integer,default=0)#用于统计该文章评论数


#这个表用来存储点赞信息，一次点赞的点赞人和他对应的点赞文章构成一个实例
class MidZan(db.Model):
    mid_zan_id = db.Column(Integer, primary_key=True, autoincrement=True)  #应该没啥用的代理主键
    session_id = db.Column(String(50),nullable=False)
    post_id = db.Column(Integer)
    #title = db.Column(String(20))   #暂时规定一个用户不能有重名文章  因此用session和title来确定是哪一篇帖子


#评论表，一个实例对应一个用户在一篇文章下的一次评论，表包含了全部每篇文章的全部评论
class MidComment(db.Model):
    mid_comment_id = db.Column(Integer, primary_key=True, autoincrement=True)  # 应该没啥用的代理主键
    session_id = db.Column(String(50),nullable=False)
    #post_id = db.Column(Integer)
    comment = db.Column(Text)                      #后续要考虑对评论的字数限制，包括上限和下限,大后期优化可以增加对垃圾评论筛除(算法)
    title = db.Column(String(20))


db.create_all()



#登录
@app.route('/login/', methods=['GET', 'POST'])
def login():
    print(request.args['code'])
    # 访问api获得用户的openid
    # appid = "wx63cc36f28105acb7"
    # secret = "c124fa1669d57f26a302d7ca486c915f"
    appid = "wx6c2280af50f3995a"
    secret = "6749a6707adf1980c7edf41dc4f0057b"
    r = requests.get('https://api.weixin.qq.com/sns/jscode2session?'
                        'appid=%s&secret=%s&js_code=%s'
                        '&grant_type=authorization_code'%(appid, secret, request.args['code']))
    if r.json()['openid']:
        print(r.json())
        open_id = r.json()['openid']
        session_id = hashlib.md5(open_id.encode(encoding='UTF-8')).hexdigest()
        print("密文", session_id)
        # 查找数据库，获取到的是一个对象列表，若没在数据库中添加新用户
        if UserInformation.query.filter_by(session_id=session_id).all():
                print("已经存在")
                pass
        else:
            print("不存在")
            user_base = UserInformation(open_id=open_id, session_id=session_id, is_active=0)
            db.session.add(user_base)
            db.session.commit()
        response = make_response(jsonify({'sessionId': session_id}), 200)
    else:
        response = make_response(" ", 404)
    return response

#获得用户信息用于渲染“个人信息”界面
@app.route('/getPersonalInfo/',methods=['POST'])
def getPersonalInfo():
    #还要把对应用户写的全部帖子信息返回
    session_id = request.form['session_id']
    if UserInformation.query.filter_by(session_id=session_id).one():
        personal = UserInformation.query.filter_by(session_id=session_id).one()
        PersonalInfo = {
            'name': personal.name,
            'gender': personal.gender,
            'PersonalWeb': personal.PersonalWeb,
            'introduction': personal.introduction
        }
        response = make_response(jsonify(PersonalInfo),200)
        return response
    else:
        return make_response(" ",404)


#获得用户信息用于渲染“学校信息”界面
@app.route('/getSchoolInfo/',methods=['POST'])
def getSchoolInfo():
    session_id = request.form['session_id']
    if UserInformation.query.filter_by(session_id=session_id).one():
        schoolInfo = UserInformation.query.filter_by(session_id=session_id).one()
        SchoolInfo = {
            'university': schoolInfo.university,
            'college': schoolInfo.college,
            'major': schoolInfo.major,
            'grade': schoolInfo.grade,
            'degree': schoolInfo.degree
        }
        response = make_response(jsonify(SchoolInfo),200)
        return response
    else:
        return make_response(" ",404)


#获得用户信息用于渲染“已发表的帖子”界面
@app.route('/getOwnPost/',methods=['POST'])
def getOwnPost():
    #注意：现在的版本是直接把该用户所有发过的帖子返回给前端，没有考虑下拉刷新
    session_id = request.form['session_id']
    if PostLibrary.query.filter_by(session_id=session_id).all():
        outputs = PostLibrary.query.filter_by(session_id=session_id).all()
        users = []
        for output in outputs:
            users.append({
                "name": output.name,
                "title": output.title,
                "summary": output.summary,
                "session_id": output.session_id,
                "id": output.id,
                "theme": output.theme,
                "zan_count": output.zan_count,
                "comment_count": output.comment_count,
                "willing": output.willing,
                "speciality": output.speciality
            })
        return make_response(jsonify(users),200)
    return make_response(" ",404)



#用户修改个人资料
@app.route('/setUserInformation/',methods=['POST'])
def setUserInformation():
    if request.form:
        session_id = request.form['session_id']
        data = request.form.to_dict()
        UserInformation.query.filter_by(session_id=session_id).update(data)
        return make_response(" ",200)
    else:
        return make_response(" ",404)


# 用户修改帖子——把帖子的内容给前端，前端显示
@app.route('/modifyPost/', methods=['GET'])
def modifyPost():
    # 暂时不能修改标题
    name = request.args['name']    #作者的名字
    title = request.args['title']
    if PostLibrary.query.filter_by(name = name,title = title).one():
        output = PostLibrary.query.filter_by(name = name,title = title).one()
        users = []
        users.append({
            "article":output.article,
            "id":output.id
        })
        return make_response(jsonify(users),200)
    return make_response(" ",404)



#把用户修改完成的信息更新到数据库
@app.route('/savePostModification/',methods=['POST'])
def savePostModification():
    title = request.args['title']
    article = request.args['article']
    id = request.args['id']
    summary = article[0,70]
    output = PostLibrary.query.filter_by(id=id).one()
    output.title = title
    output.article = article
    output.summary = summary
    db.session.commit()
    return make_response(" ",200)





#点击进入各个板块，显示属于该板块的所有文章缩小版(作者标题摘要赞数)
@app.route('/getIntoPlate/',methods=['GET'])
def getIntoPlate():
    # 考虑实现
    #确定一页能展示多少个缩小版，一次只返回相应数量的缩小版信息
    #设置一个断点信息，保存当前显示到了哪个位置，当用户下拉刷新，再展示几个，循环往复
    #后期还可以考虑把不同板块的文章放在不同的数据表中，这样可以减少进入各个板块时的查询时间
    theme = request.args['args']
    if PostLibrary.query.filter_by(theme=theme).all():
        outputs = PostLibrary.query.filter_by(theme=theme).all()
        users = []
        for output in outputs:
            users.append({
                "name": output.name,
                "title": output.title,
                "summary": output.summary,
                "session_id": output.session_id,
                "id": output.id,
                "zan_count": output.zan_count,
                "comment_count": output.comment_count
            })
        return make_response(jsonify(users), 200)
    return make_response(" ", 404)



#用户点击查看对应帖子
@app.route('/readPost/',methods=['GET'])
def readPost():
    post_id = request.args['post_id']    #帖子的名字
    session_id = request.args['session_id']   #用户的session_id
    sign = 1
    if PostLibrary.query.filter_by(post_id=post_id).one():
        if MidZan.query.filter_by(post_id=post_id,session_id=session_id).one():
            sign = 0    #这个标志用于表示能不能点赞，0是不能，1是可以
        output = PostLibrary.query.filter_by(id=id).one()
        users = []
        users.append({
            "name":output.name,
            "title":output.title,
            "article":output.article,
            "zan_count":output.zan_count,
            "comment_count":output.comment_count,
            "sign":sign
        })
        return make_response(jsonify(users),200)
    return make_response(" ",404)



#用户写帖子
@app.route('/writePose/',methods=['POST'])
def writePose():
    session_id = request.form['session_id']
    title = request.form['title']
    article = request.form['article']
    theme = request.form['theme']
    #name summary
    output = UserInformation.query.filter_by(session_id=session_id).one()
    name = output.name
    summary = article[0:70]
    PostLibrary1 = PostLibrary(session_id=session_id,title=title,article=article,theme=theme,name=name,summary=summary,zan_count=0,comment_count=0)
    db.session.add(PostLibrary1)
    db.session.commit()
    return make_response(" ",200)






#主页搜索功能
@app.route('/search/',methods=['GET'])
def search():
    #当前是简易版本，只对文章标题和前七十字进行检索
    #没想好怎么让搜索到的内容分页显示（下拉刷新）
    key_word = request.args['key_word']
    outputs = PostLibrary.query.filter(or_(PostLibrary.summary.like('%'+key_word+'%'),PostLibrary.title.like('%'+key_word+'%'))).all()
    user = []
    for output in outputs:
        user.append({
            "name": output.name,
            "title": output.title,
            "summary": output.summary,
            "session_id": output.session_id,
            "id": output.id,
            "zan_count": output.zan_count,
            "comment_count": output.comment_count
        })
    return make_response(jsonify(user),200)



#对相应的文章点赞功能
@app.route('/praise/',methods=['POST'])
def praise():
    session_id = request.form['session_id']
    post_id = request.form['post_id']
    #文章点赞数统计加一
    PostLibrary1 = PostLibrary.query.filter_by(post_id=post_id).one()
    PostLibrary1.zan_count = PostLibrary1.zan_count + 1
    #点赞表增加一个实例
    MidZan1 = MidZan(post_id=post_id,session_id=session_id)
    db.session.add(MidZan1)
    db.session.commit()
    return make_response(" ",200)


#评论功能
def comment():

    pass







#if __name__ == '__mian__':
    #生产环境 nginx+uwsgi if name的作用在于防止加载两个服务器
app.run(host='0.0.0.0',debug=app.config['DEBUG'],port=5000)
