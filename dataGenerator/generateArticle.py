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
try:
    cnx = mysql.connector.connect(user='root', password='wzy960806', host='localhost'
    , database='bbs', auth_plugin='mysql_native_password')
except mysql.connector.Error as err:
    print(err)
else:
    cursor = cnx.cursor()
    for userIndex in range(1, userNum + 1): 
        for j in range(3):
            seed = j
            filename = "articleSeed" + str(seed) + '.txt'
            f = open(filename, 'r')
            seedContent = f.read()
            f.close()
            text = bytes(seedContent, "UTF-8")
            text = text.decode("ascii", "ignore")
            wordDict = buildWordDict(text)
            sectionID = seed + 1
            userID = userIndex
            postTime = time.strftime('%Y-%m-%d %H:%M:%S')
            clickNum = randint(0, 200)

            conLength = randint(50, 100)
            content = ""
            currentWord = randomFirstWord(wordDict)
            punctList = [',', '.', '?', '!', ':']
            for k in range(0, conLength):
                if (currentWord[0] not in punctList and k > 0):
                    content += " "
                content += currentWord
                currentWord = retrieveRandomWord(wordDict[currentWord])

            titleLength = randint(3, 6)
            title = ""
            currentWord = randomFirstWord(wordDict)
            for k in range(0, titleLength):
                if (currentWord[0] not in punctList and k > 0):
                    title += " "
                title += currentWord
                currentWord = retrieveRandomWord(wordDict[currentWord])

            print(title)
            print(content)

            add_post = ("INSERT INTO posts "
                "(sectionID, userID, title, content, postTime, clickNum) "
                "VALUES (%(sectionID)s, %(userID)s, %(title)s, %(content)s, %(postTime)s, %(clickNum)s)")
            data_post = {
                'sectionID': int(sectionID),
                'userID': int(userID),
                'title': title,
                'content': content,
                'postTime': postTime,
                'clickNum': clickNum,
            }
            cursor.execute(add_post, data_post)
            cnx.commit()
    cursor.close()
    cnx.close()