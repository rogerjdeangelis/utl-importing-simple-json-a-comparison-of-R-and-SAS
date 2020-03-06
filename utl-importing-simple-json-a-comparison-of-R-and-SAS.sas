Importing simple json a comparison of R and SAS

github
https://tinyurl.com/sz7ggnz
https://github.com/rogerjdeangelis/utl-importing-simple-json-a-comparison-of-R-and-SAS

SAS Forum
https://tinyurl.com/u3uwczy
https://communities.sas.com/t5/SAS-Programming/Tokenising-a-string/m-p/627715

*_                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;

filename ft15f001  "d:/json/simple.json";
parmcards4;
[{"question":"Reference Number","answer":"5e57064595e4da0011efcde8"},
{"question":"Timestamp","answer":"Thu, 27 Feb 2020 07:59:01 AM"},
{"question":"I am","answer":"Delivery Staff"},
{"question":"Please specify other purpose of visit","answer":""},
{"question":"Going to...","answer":"Others:"},
{"question":"Location - Wards/Clinic","answer":""},
{"question":"Location-Nursing Homes/Care Centres","answer":""}]
;;;;
run;quit;


*                            _               _
 ___  __ _ ___    ___  _   _| |_ _ __  _   _| |_
/ __|/ _` / __|  / _ \| | | | __| '_ \| | | | __|
\__ \ (_| \__ \ | (_) | |_| | |_| |_) | |_| | |_
|___/\__,_|___/  \___/ \__,_|\__| .__/ \__,_|\__|
                                |_|
;

WORK.WANTSAS total obs=14

Obs    P       P1       V    VALUE

  1    1    question    1    Reference Number
  2    1    answer      1    5e57064595e4da0011efcde8
  3    1    question    1    Timestamp
  4    1    answer      1    Thu, 27 Feb 2020 07:59:01 AM
  5    1    question    1    I am
  6    1    answer      1    Delivery Staff
  7    1    question    1    Please specify other purpose of visit
  8    1    answer      1
  9    1    question    1    Going to...
 10    1    answer      1    Others:
 11    1    question    1    Location - Wards/Clinic
 12    1    answer      1
 13    1    question    1    Location-Nursing Homes/Care Centres
 14    1    answer      1

*                   _               _
 _ __    ___  _   _| |_ _ __  _   _| |_
| '__|  / _ \| | | | __| '_ \| | | | __|
| |    | (_) | |_| | |_| |_) | |_| | |_
|_|     \___/ \__,_|\__| .__/ \__,_|\__|
                       |_|
;

WORK.WANT total obs=7

bs    QUESTION                                 ANSWER

1     Reference Number                         5e57064595e4da0011efcde8
2     Timestamp                                Thu, 27 Feb 2020 07:59:01 AM
3     I am                                     Delivery Staff
4     Please specify other purpose of visit
5     Going to...                              Others:
6     Location - Wards/Clinic
7     Location-Nursing Homes/Care Centres

*
 ___  __ _ ___   _ __  _ __ ___   ___ ___  ___ ___
/ __|/ _` / __| | '_ \| '__/ _ \ / __/ _ \/ __/ __|
\__ \ (_| \__ \ | |_) | | | (_) | (_|  __/\__ \__ \
|___/\__,_|___/ | .__/|_|  \___/ \___\___||___/___/
                |_|
;

libname jsn json "d:/json/simple.json" automap=reuse;
data wantsas;
  set jsn.alldata;
run;quit;

*
 _ __   _ __  _ __ ___   ___ ___  ___ ___
| '__| | '_ \| '__/ _ \ / __/ _ \/ __/ __|
| |    | |_) | | | (_) | (_|  __/\__ \__ \
|_|    | .__/|_|  \___/ \___\___||___/___/
       |_|
;

%utl_submit_r64('
   library(rio);
   library(haven);
   library(data.table);
   want<-as.data.table(as.list(import("d:/json/simple.json")));
   write_xpt(want,"d:/xpt/want.xpt",version=8);
 ');

 %xpt2loc(libref=work,
   memlist=_all_,
   filespec='d:/xpt/want.xpt' );

proc print data=want;
run;quit;


