
# max lines of text = 255?

text = {
       #"##############################",
    "EmbarkText": [
        "YOU STARTED DOWN THE TRAIL",
        " WITH xx OXEN, xx SETS OF",
        " CLOTHING, xxxx BULLETS,",
        " x WHEELS, x AXLES, x TONGUES,",
        " xxxx l OF FOOD, AND $xxxx.*."   
    ], #"##############################",
    "RationsChange": [
        "YOU CHANGED YOUR RATIONS TO"
    ], #"##############################",
    "BoughtStore": [
        "YOU BOUGHT",
        " AT THE STORE FOR $xxxx.*."
    ], #"##############################",
    "TradeItems": [
        "YOU TRADED",
        " FOR"
    ], #"##############################",
    "Rest": [
        "YOU DECIDE TO REST FOR x DAYS."
    ], #"##############################",
    "PaceChange": [
        "YOU DECIDE TO CHANGE THE PACE",
        " TO"
    ], #"##############################",
    "HuntBegin": [
        "YOU DECIDE TO HUNT."
    ], #"##############################",
    "HuntResults": [
        "YOU BROUGHT BACK xxxl OF FOOD",
        " AND USED xx BULLETS."
    ], #"##############################",
    "HuntScarce": [
        "IF YOU CONTINUE TO HUNT HERE,",
        " GAME WILL BECOME SCARCE."
    ], #"##############################",
    "HuntForbidden": [
        "HUNTING IS NOT ALLOWED HERE,",
        " THERE ARE TOO MANY PEOPLE."
    ], #"##############################",
    "RiverDecision": [
        "> ATTEMPT TO FORD THE RIVER",
        "YOU CHOSE TO FORD THE RIVER.",
        "> CAULK THE WAGON AND FLOAT",
        "YOU CAULK YOUR WAGON AND",
        " FLOAT ACROSS.",
        "> TAKE FERRY FOR $5.00",
        "YOU CHOSE TO TAKE A FERRY",
        " ACROSS THE RIVER.",
        "> HIRE AN INDIAN TO HELP FOR",
        "   xxxxxxxxxxxxxxxx",
        "YOU CHOSE TO HAVE AN INDIAN",
        " GUIDE HELP YOU CROSS."
    ], #"##############################",
    "RiverResult": [
        "YOU MADE IT SAFELY ACROSS",
        " THE RIVER.",
        "xxxx DROWNED.",
        "YOUR WAGON SANK AND YOU LOST",
        " xxxx, xxxxxxx, xxxxxxx."
        "YOUR WAGON TIPPED. FORTUNATELY",
        " NOBODY WAS INJURED AND YOU",
        " RECOVERED ALL YOUR SUPPLIES."
    ], #"##############################",
    "RandomEvent": [
        "A THIEF STOLE xxxxxxxxxxxxxxxx",
        " FROM YOUR WAGON.",
        "YOU TOOK THE WRONG TRAIL.",
        "YOU LOST THE TRAIL.",
        "NO GRASS FOR THE OXEN.",
        "NO WATER.",
        "BAD WATER.",
        "xxxx GOT LOST.",
        "AN OX IS SICK.",
        "AN OX DIED.",
        "THE TRAIL IS IMPASSABLE.",
        "HEAVY FOG.",
        "YOU HAD A WAGON xxxxxx BREAK",
        " BUT WERE ABLE TO FIX IT.",
        " BUT WERE ABLE TO REPLACE IT.",
        "ROUGH TRAIL.",
        "YOU FIND SOME WILD FRUIT.",
        "YOU FOUND xxxxxxxxxxxxxxxxxxxx",
        " IN AN ABANDONED WAGON.",
        "A FIRE IN YOUR WAGON DESTROYED",
        " xxxx, xxxx, xxxx.",
        "xxxx GOT SICK AND DIED."
    ], #"##############################",
    "Affliction": [
        "xxxx HAS A FEVER.",
        "xxxx HAS DYSENTERY.",
        "xxxx HAS THE MEASLES.",
        "xxxx WAS BITTEN BY A SNAKE.",
        "xxxx IS SUFFERING FROM",
        " EXHAUSTION.",
        "xxxx IS SICK WITH",
        " TYPHOID FEVER.",
        "xxxx HAS CHOLERA.",
        "xxxx HAS A BROKEN ARM.",
        "xxxx HAS A BROKEN LEG."
    ], #"##############################",
    "AfflictionHealed": [
        "xxxx IS WELL AGAIN."
    ], #"##############################",
    "AfflictionDied": [
        "xxxx DIED OF A SNAKE BITE.",
        "xxxx DIED OF A FEVER.",
        "xxxx DIED OF THE MEASLES.",
        "xxxx DIED FROM EXHAUSTION.",
        "xxxx DIED OF TYPHOID FEVER.",
        "xxxx DIED OF CHOLERA.",
        "xxxx DIED OF DYSENTERY."
    ],
    "TrailDivides": [
        "THE TRAIL DIVIDES HERE. WHICH",
        " WAY DO YOU WANT TO GO?"
    ], #"##############################",
    "TrailDecision": [
        "YOU DECIDE TO TAKE THE TRAIL",
        " TO "
    ], #"##############################",
    "TrailOptionSouthPass": [
        "> HEAD TO FORT BRIDGER TO BUY",
        "   SUPPLIES",
        "> TAKE THE SHORTCUT TO THE",
        "   GREEN RIVER"
    ], #"##############################",
    "TrailOptionGrandRonde": [
        "> HEAD TO FORT WALLA WALLA TO",
        "   BUY SUPPLIES",
        "> TAKE THE SHORTCUT TO",
        "   THE DALLES"
    ], #"##############################",
    "TrailOptionDalles": [
        "> TAKE THE BARLOW TOLL ROAD",
        "> RAFT DOWN THE RIVER"
    ], #"##############################",
    "Reached": [
        "YOU HAVE REACHED"
    ], #"##############################",
    "Locations": [
        " INDEPENDENCE, MISSOURI.",
        " THE KANSAS RIVER CROSSING.",
        " THE BIG BLUE RIVER CROSSING.",
        "FORT KEARNEY.",
        "CHIMNEY ROCK.",
        "FORT LARAMIE.",
        " INDEPENDENCE ROCK.",
        "SOUTH PASS.",
        "FORT BRIDGER.",
        " THE GREEN RIVER CROSSING.",
        "SODA SPRINGS.",
        "FORT HALL."
        " THE SNAKE RIVER CROSSING.",
        "FORT BOISE.",
        "GRANDE RONDE",
        " IN THE BLUE MOUNTAINS.",
        " FORT WALLA WALLA."
        "THE DALLES."
    ]  #"##############################",
}

def bytify(text):
    special = {
        ' ': '___',
        '.': '_PD',
        ',': '_CM',
        'l': '_LB',
        '?': '_QU',
        '!': '_EX',
        ':': '_CL',
        '$': '_DL',
        '*': '_00',
        '>': '___',
        'x': '_X_'
    }
    asm = []
    for label in text:
        asm.append(f"diary{label}:")
        for line in text[label]:
            byte = []
            for char in line:
                ch = f"_{char}_"
                if char in special:
                    ch = special[char]
                byte.append(ch)
            while len(byte) < 30:
                byte.append('___')
            if len(byte) > 30:
                print(f"Error: line too long\n{label}: {line}")
                exit()
            asm.append("    .byte " + ','.join(byte))
        asm.append("\n")
    return asm

def main():
    asm = bytify(text)
    with open('src/diarytext.inc','w') as f:
        f.write(';-------------------------------------------------------------------------------'+"\n")
        f.write('.SEGMENT "RODATA"'+"\n\n")
        for line in asm:
            f.write(line + "\n")

if __name__ == "__main__":
    main()