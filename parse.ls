require! fs
Pages = JSON.parse(fs.read-file-sync \01.json \utf8).formImage.Pages
#Pages = JSON.parse(fs.read-file-sync \input.json \utf8)

const VerticalFormMapping = {"\uFE10": "\uFF0C", "\uFE11": "\u3001", "\uFE12": "\u3002", "\uFE13": "\uFF1A", "\uFE14": "\uFF1B", "\uFE15": "\uFF01", "\uFE16": "\uFF1F", "\uFE17": "\u3016", "\uFE18": "\u3017", "\uFE19": "\u2026", "\uFE30": "\u2025", "\uFE31": "\u2014", "\uFE32": "\u2013", "\uFE33": "\uFF3F", "\uFE34": "\uFE4F", "\uFE35": "\uFF08", "\uFE36": "\uFF09", "\uFE37": "\uFF5B", "\uFE38": "\uFF5D", "\uFE39": "\u3014", "\uFE3A": "\u3015", "\uFE3B": "\u3010", "\uFE3C": "\u3011", "\uFE3D": "\u300A", "\uFE3E": "\u300B", "\uFE3F": "\u3008", "\uFE40": "\u3009", "\uFE41": "\u300C", "\uFE42": "\u300D", "\uFE43": "\u300E", "\uFE44": "\u300F", "\uFE47": "\uFF3B", "\uFE48": "\uFF3D" }
h2v = (.replace /[︐︑︒︓︔︕︖︗︘︙︰︱︲︳︴︵︶︷︸︹︺︻︼︽︾︿﹀﹁﹂﹃﹄﹇﹈]/g -> VerticalFormMapping[it])

SizeMap = {
  11.5039: '### 頁碼'
  13.7717: '### 正文'
  13.063: '### 楷書'
  24.5433: '### 破折號'
  22.8425: '### 大標'
  16.4646: '### 小標'
  11.6173: '### 英數'
}
output = ''
for {Texts} in Pages
  prev-x = sz = 0
  for {x, y, R} in Texts
    if x isnt prev-x
      output += "\n\n#{ SizeMap[sz] || sz }\n" if 5.5 > y > 4.5
      prev-x = x
    for {S, T, TS} in R
      continue if TS.1 is 9 or TS.1 is 10.795300000000001
      if S is -1
        if sz isnt TS.1
          sz = TS.1
          output += "\n\n#{ SizeMap[sz] || sz }\n"
      output += h2v decodeURIComponent T
console.log output
