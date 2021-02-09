#!/usr/bin/ghci
--Title: Caesar-Verschluesselung

buchstabe = 'n'

klar = ['a'..'z']
geheim = [buchstabe..'z'] ++ ['a'..pred buchstabe]

caesarEncryptDict = zip klar geheim
caesarDecryptDict = zip geheim klar

removeNonLetters :: [Char] -> [Char]
removeNonLetters st = [ c | c <- st, c `elem` ['a'..'z'] ++ ['A'..'Z']]

removeUppercase :: String -> String
removeUppercase str = [ c | c <- str, c `elem` ['a'..'z']]

rot13 :: Char -> Char
rot13 c = succ succ succ succ succ succ succ succ succ succ succ succ succ c

klartext = "huhu"
encryptRot13 str = [ rot13 c | c <- str]
geheimtext = encryptRot13 klartext

--noch nicht übertragen aus Python 3
{-
def caesardict_vv(codedict):
    code = {wert : schluessel for (schluessel, wert) in codedict}
    return code

def codieren(text, codedict):
    text = text.lower()
    geheim = ""
    for b in text:
        if b in codedict:
            neu = codedict[b]
        else:
            neu = b
        geheim = geheim + neu
    return geheim
-}
