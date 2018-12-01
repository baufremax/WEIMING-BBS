#!/usr/bin/env python
import names
import random
import mysql.connector
import time

userNum = 50

config = {
  'user': 'root',
  'password': 'wzy960806',
  'host': '127.0.0.1',
  'database': 'bbs',
  'auth_plugin': 'mysql_native_password',
#   'raise_on_warnings': True
}

def generate(num): 
    try:
        cnx = mysql.connector.connect(user='root', password='wzy960806', host='localhost'
        , database='bbs', auth_plugin='mysql_native_password')
    except mysql.connector.Error as err:
        print(err)
    else:
        cursor = cnx.cursor()
        for i in range(num):
            genderSeq = ['female', 'male']
            userGender = random.choice(genderSeq)
            userFirstName = names.get_first_name(gender=userGender)
            userLastName = names.get_last_name()
            userName = userFirstName + ' ' + userLastName;
            s = "abcdefghijklmnopqrstuvwxyz01234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            userPassword = ''.join(random.sample(s, random.randint(4, 10)))
            birthYear = random.randint(1970, 2000)
            birthMonth = random.randint(1, 12)
            if (birthMonth == 2):
                birthDay = random.randint(1, 28)
            elif (birthMonth in [4, 6, 9, 11]):
                birthDay = random.randint(1, 30)
            else :
                birthDay = random.randint(1, 31)
            userBirth = str(birthYear) + '-' + str(birthMonth).zfill(2) + '-' + str(birthDay).zfill(2)
            userEmail = userFirstName + userLastName + userPassword[0] + "@gmail.com"
            if (userGender == 'female'):
                userGender = 'F'
            else:
                userGender = 'M'

            print('__'.join([userName, userGender, userPassword, userBirth, userEmail]))
            
            now = time.strftime('%Y-%m-%d %H:%M:%S')
            
            add_user = ("INSERT INTO bbsUser "
            "(nickname, userPassword, gender, birthdate, registerDate, email) "
            "VALUES (%(nickname)s, %(userPassword)s, %(gender)s, %(birthdate)s, %(registerDate)s, %(email)s)")
            data_user = {
                'nickname': userName,
                'userPassword': userPassword,
                'gender': userGender,
                'birthdate': userBirth,
                'registerDate': now,
                'email': userEmail,
            }
            cursor.execute(add_user, data_user)
            cnx.commit()
        cursor.close()
        cnx.close()

if __name__ == '__main__':
    generate(userNum)
