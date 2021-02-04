#!/usr/bin/env python3
# Title: Caesar-Verschluesselung


def caesardict(buchstabe):
    klar = "abcdefghijklmnopqrstuvwxyz"
    i = klar.index(buchstabe)
    geheim = klar[i:] + klar[:i]
    code = dict(zip(klar, geheim))
    return code


def caesardict_vv(codedict):
    code = {wert: schluessel for (schluessel, wert) in codedict}
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
