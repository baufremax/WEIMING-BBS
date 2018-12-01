from random import randint
import re
import mysql.connector
import time

def wordListSum(wordList):
    sum = 0
    for word, value in wordList.items():
        sum = sum + value
    return sum

def retrieveRandomWord(wordList):

    randomIndex = randint(1, wordListSum(wordList))
    for word, value in wordList.items():
        randomIndex -= value
        if randomIndex <= 0:
            return word

def buildWordDict(text):
    text = re.sub('(\n|\r|\t)+', " ", text)
    text = re.sub('\"', "", text)

    punctuation = [',', '.', ';', ':']
    for symbol in punctuation:
        text = text.replace(symbol, " " + symbol + " ")

    words = text.split(' ')

    words = [word for word in words if word != ""]
    wordDict = {}
    for i in range(1, len(words)):
        if words[i-1] not in wordDict:
            wordDict[words[i-1]] = {}
        if words[i] not in wordDict[words[i-1]]:
            wordDict[words[i-1]][words[i]] = 0
        wordDict[words[i-1]][words[i]] = wordDict[words[i-1]][words[i]] + 1

    return wordDict

def randomFirstWord(wordDict):
    randomIndex = randint(0, len(wordDict))
    return list(wordDict.keys())[randomIndex]

seed = randint(0, 2)
filename = "articleSeed" + str(seed) + '.txt'
print(filename)
f = open(filename, 'r')
seedContent = f.read()
text = bytes(seedContent, "UTF-8")
text = text.decode("ascii", "ignore")
wordDict = buildWordDict(text)

userNum = 50
postNum = 200
try:
    cnx = mysql.connector.connect(user='root', password='wzy960806', host='localhost'
    , database='bbs', auth_plugin='mysql_native_password')
except mysql.connector.Error as err:
    print(err)
else:
    cursor = cnx.cursor()
    # generate reply for each user.
    for userIndex in range(1, userNum + 1): 
        # for j in range(4):
        seed = randint(0, 2)
        filename = "articleSeed" + str(seed) + '.txt'
        f = open(filename, 'r')
        seedContent = f.read()
        f.close()
        text = bytes(seedContent, "UTF-8")
        text = text.decode("ascii", "ignore")
        wordDict = buildWordDict(text)

        conLength = randint(10, 20)
        content = ""
        currentWord = randomFirstWord(wordDict)
        punctList = [',', '.', '?', '!', ':']
        for i in range(0, conLength):
            if (currentWord[0] not in punctList and i > 0):
                content += " "
            content += currentWord
            currentWord = retrieveRandomWord(wordDict[currentWord])
        print(content)
        print(i)
        postID = randint(201, 276)
        postID = randint(1, postNum)
        userID = userIndex
        replyTime = time.strftime('%Y-%m-%d %H:%M:%S')
        praiseNum = randint(0, 50)
        add_reply = ("INSERT INTO replys "
            "(postID, userID, replyContent, replyTime, praiseNum) "
            "VALUES (%(postID)s, %(userID)s, %(content)s, %(replyTime)s, %(praiseNum)s)")
        data_reply = {
            'postID': int(postID),
            'userID': int(userID),
            'content': content,
            'replyTime': replyTime,
            'praiseNum': praiseNum,
        }
        cursor.execute(add_reply, data_reply)
        cnx.commit()
    cursor.close()
    cnx.close()