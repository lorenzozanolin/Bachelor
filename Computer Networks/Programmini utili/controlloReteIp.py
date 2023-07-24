#programmino per verificare la rete di un ip, facendo AND tra ip e maschera

print("inserisci l'ip")
ip = input()

print("inserisci subnet mask")
subnet = input()

indirizzo = ip.split(".") # indirizzo contiene una lista/array contenenti le 4 parti dell'indirizzo
subnet = subnet.split(".")

subnetInBinario = []
indirizzoInBinario = [] #cosi ho dichiarato una lista/array che sono eterogenee (posso salvare tipi diversi) e infiniti

for i in indirizzo: #prima lo converto da stringa a intero, poi lo converto da decimale a binario
    indirizzoInBinario.append((bin(int(i))[2:]).zfill(8)) # [2:] facendo cosi taglio i primi due caratteri e cosi stampo il valore binario, .zfill(8) mi riempre di 8 zeri a sx in modo da raggiungere 8 zeri

for i in subnet:
    subnetInBinario.append(bin(int(i))[2:].zfill(8))

print("indirizzo IP in binario:")
print(".".join(indirizzoInBinario)) #join prende l'array e lo comprime usando come divisore il "."
print("subnet mask in binario:")
print(".".join(subnetInBinario)) 

rete = []

for i in range(len(subnetInBinario)):
    rete.append( int(indirizzoInBinario[i],2) & int(subnetInBinario[i],2))
print("rete di appartenenza dell'indirizzo:")
print('.'.join([str(i) for i in rete]))