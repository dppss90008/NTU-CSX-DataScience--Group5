with open("NTUSD_positive_UTF-8.txt","r",encoding="UTF-8") as file:
      txt = file.readlines()

for i in range(len(txt)):
      txt[i]= txt[i].strip()
    
      
with open("NTUSD_positive_UTF-8.csv","w",encoding="UTF-8") as file:
      for i in range(len(txt)):
            file.write(txt[i])
            file.write("\n")
