# advent2017Q
KDB solutions to advent


D1
p1
captcha:"5672987533353956199629683941564528646262567117433461547747793928322958646779832484689174151918261551689221756165598898428736782194511627829355718493723961323272136452517987471351381881946883528248611611258656199812998632682668749683588515362946994415852337196718476219162124978836537348924591957188827929753417884942133844664636969742547717228255739959316351852731598292529837885992781815131876183578461135791315287135243541659853734343376618419952776165544829717676988897684141328138348382882699672957866146524759879236555935723655326743713542931693477824289283542468639522271643257212833248165391957686226311246517978319253977276663825479144321155712866946255992634876158822855382331452649953283788863248192338245943966269197421474555779135168637263279579842885347152287275679811576594376535226167894981226866222987522415785244875882556414956724976341627123557214837873872723618395529735349273241686548287549763993653379539445435319698825465289817663294436458194867278623978745981799283789237555242728291337538498616929817268211698649236646127899982839523784837752863458819965485149812959121884771849954723259365778151788719941888128618552455879369919511319735525621198185634342538848462461833332917986297445388515717463168515123732455576143447454835849565757773325367469763383757677938748319968971312267871619951657267913817242485559771582167295794259441256284168356292785568858527184122231262465193612127961685513913835274823892596923786613299747347259254823531262185328274367529265868856512185135329652635938373266759964119863494798222245536758792389789818646655287856173534479551364115976811459677123592747375296313667253413698823655218254168196162883437389718167743871216373164865426458794239496224858971694877159591215772938396827435289734165853975267521291574436567193473814247981877735223376964125359992555885137816647382139596646856417424617847981855532914872251686719394341764324395254556782277426326331441981737557262581762412544849689472281645835957667217384334435391572985228286537574388834835693416821419655967456137395465649249256572866516984318344482684936625486311718525523265165"
sum "I"$'captcha -1+where not differ captcha,first captcha
p2
{sum "I"$'x where last flip not differ each x (til count x),'(div[count x;2]+til count x) mod count x} captcha
D2
p1
spreadsheet:"626	2424	2593	139	2136	163	1689	367	2235	125	2365	924	135	2583	1425	2502
183	149	3794	5221	5520	162	5430	4395	2466	1888	3999	3595	195	181	6188	4863
163	195	512	309	102	175	343	134	401	372	368	321	350	354	183	490
2441	228	250	2710	200	1166	231	2772	1473	2898	2528	2719	1736	249	1796	903
3999	820	3277	3322	2997	1219	1014	170	179	2413	183	3759	3585	2136	3700	188
132	108	262	203	228	104	205	126	69	208	235	311	313	258	110	117
963	1112	1106	50	186	45	154	60	1288	1150	986	232	872	433	48	319
111	1459	98	1624	2234	2528	93	1182	97	583	2813	3139	1792	1512	1326	3227
371	374	459	83	407	460	59	40	42	90	74	163	494	250	488	444
1405	2497	2079	2350	747	1792	2412	2615	89	2332	1363	102	81	2346	122	1356
1496	2782	2257	2258	961	214	219	2998	400	230	2676	3003	2955	254	2250	2707
694	669	951	455	2752	216	1576	3336	251	236	222	2967	3131	3456	1586	1509
170	2453	1707	2017	2230	157	2798	225	1891	945	943	2746	186	206	2678	2156
3632	3786	125	2650	1765	1129	3675	3445	1812	3206	99	105	1922	112	1136	3242
6070	6670	1885	1994	178	230	5857	241	253	5972	7219	252	806	6116	4425	3944
2257	155	734	228	204	2180	175	2277	180	2275	2239	2331	2278	1763	112	2054"
mat:"I"$"\t" vs/: "\n" vs spreadsheet

sum .[-;] (max;min)@\: flip mat

p2
diag:{(x;x)#1,(x#0)}
sum .[%;] flip {x {(raze i),where count each i:where each x} {neg[diag count x]+0=x mod/: x} x} each mat

D3
p1
input:289326
all {(1+(4*x)+x*x)=(x+2)*(x+2)} 1+til 10000

f:{[input]
	nbrc:{?[1h$x mod 2;x;x-1]} (floor sqrt input);  /nearest bottom corner
	grid:(1+2*til input)?nbrc;
	trc:nbrc+1+ brc:nbrc*nbrc; /top right corner
	tlc:nbrc+1+trc;
	blc:nbrc+1+tlc;
	$[brc=input;(neg[grid];grid);
		blc<=input;(neg[1+grid];neg[1+grid]+(input-blc));
		tlc<=input;(1+grid-input-tlc;neg[1+grid]);
		trc<=input;(1+grid;1+grid-input-trc);
			(neg[grid]+input-brc+1;grid+1)]
	}

sum abs f 289326
evolute:{(x;x)#iasc sums -1 rotate raze (-1 _ raze 2#'1+til x)#'(-1+2*x)#(1;neg x;-1;x)}
sm:{([]row:where count each i;col:raze i;val:raze x@'i:where each x<>0)} /dense to sparse
g:{([]row: neg j div 2;col:neg j div 2;val:enlist[0b])+sm reverse (1+evolute j:$[mod[j:ceiling sqrt x;2];j;j+1])=x}

{(x;x)#iasc sums -1 rotate (1;neg x;-1;x)@(where 1+where ((x-1)#2),1) mod (x-1)}


p2

neighbors:{flip x+flip (0 0;0 1;1 1;1 0;1 -1;0 -1;-1 -1;-1 0;-1 1)}
a:.[99 99#0;49 49;:;1]
b:.[5 5#0;2 2;:;1]
sumN:{sum over .[x;] each tran[x] neighbors y}
tran:{i:div[count x;2]; (i+y)}
res:{$[z<max over x;x;.[x;tran[x] y;:;sumN[x;y]]]}/[a;f each 1+til 1000;289326]
max over res
evolute 8
f each 1+ til 8
{5 5 #iasc sums -1 rotate (-1;x;1;neg x)(where where (x#2),1) mod 4} 5

D4
p1
input:("kvvfl kvvfl olud wjqsqa olud frc";"slhm rdfm yxb rsobyt rdfm";"pib wzfr xyoakcu zoapeze rtdxt rikc jyeps wdyo hawr xyoakcu hawr";"ismtq qwoi kzt ktgzoc gnxblp dzfayil ftfx asscba ionxi dzfayil qwoi";"dzuhys kfekxe nvdhdtj hzusdy xzhehgc dhtvdnj oxwlvef";"gxg qahl aaipx tkmckn hcsuhy jsudcmy kcefhpn kiasaj tkmckn";"roan kqnztj edc zpjwb";"yzc roc qrygby rsvts nyijgwr xnpqz";"jqgj hhgtw tmychia whkm vvxoq tfbzpe ska ldjmvmo";"nyeeg omn geyen ngyee rcjt rjuxh";"qpq udci tnp fdfk kffd eyzvmg ufppf wfuodj toamfn tkze jzsb";"rrcgxyp rbufd tfjmok vpyhej hcnz ftkojm";"jnmomfc jnmomfc bkluz izn ovvm flsch bkluz";"odisl hzwv hiasrhi hez ihihsra qpbmi ltwjj iknkwxf nbdtq gbo";"gjtszl gjtszl fruo fruo";"rdapv gaik cqboix sxnizhh uxmpali jdd usqnz advrp dze";"flooz flooz qad tcrq yze bnoijff qpqu vup hyagwll";"lnazok dze foi tqwjsk hpx qcql euzpj mwfrk";"ilb fmviby ivybmf gtx xtg";"rpauuu timere gyg wcolt ireetm safi";"croe szwmq bbhd lciird vhcci pdax";"hnc ykswt qqqmei goe bri wmyai hnc qpgqc pberqf bzs";"hsnrb wdvh iezzrq iezzrq rdbmpta iezzrq kemnptg alkjnp wymmz";"ngw don ddvyds nlhkoa aaf gptumum ugtpmmu";"vmccke qbpag kvf kvf tgrfghb kvf bhpd sglgx";"obomgk bkcgo yso ttft vbw ckl wjgk";"fli qvw zhin dfpgfjb udsin nihz ovr tiewo";"tgmzmph hauzieo jmg tdbtl lvfr qpaayq qapaqy ausioeu jun piygx";"jkp guqrnx asdqmxf vmfvtqb tloqgyo ioix gajowri tmek ilc puhipb";"uycn zxqm znft ayal znacus kvcyd ekv qqfpnh";"fqghur xtbtdd ztjrylr bpuikb ziyk";"rvakn uqbl ozitpdh uqbl dsej xehj";"laxp haz jyd xnkrb ijldth woy xapl iqgg alpx gnupa ukptmmh";"dyiy dyiy ihb qcyxr";"wbwkd hdwu zvgkn hdwu wjc sakwhn zxujdo npllzp uyr uyr";"fxczpmn cininu akcxs ggslxr riyxe ojisxe";"ppbch sampq dnct afikor dnct edsqy pnzyzmc afikor";"jnvygtn hijqjxl vsd jnvygtn nqcqv zns odq gkboxrv kolnq wrvd";"mroq mroq flsbu flsbu";"fyshor xvpaunj qmktlo xoce wkiyfu ukcl srndc ugwylwm ozcwdw mtqcste kpokr";"cfh cxjvx cfh cfh uewshh";"bpspbap bpspbap fquj mxmn bwls iirhvuk dmpkyt exrn mxmn";"tvyvzk ezszod ntxr xtnr och";"knfxhy kbnyl knfxhy xhkssx lxru uprh nkxpbx oodolxr tpvyf";"nblmysu iwoffs upgof tyagwf aan vovji ajk ywzq oyfi sfulz";"aushzkm lcaeki mkuzsah ynxvte rsntd refk pcm";"mgguob gobmug dzenpty gmogbu";"yvq eepof rgnree nerger fpb stfrln ernger";"hrgkbl mzwvswk rsrsbk ieru holco pajvvn ztgsr qkyp fyeg owpcmoj";"fowda gmsqdca yugj mcrroxv mqcbojd fjnqfji qdfsc jqs";"qnc rvjfz vvxk sjd xrma ucdjvq sbw zydyt dfzww";"ocajazv cozaajv tqunkla udwf ecnnmbz lsakqg bki njnda zsdu ccfqw rxpc";"qqm qdfya qxyx qmq qfday uqnfttt";"rnbirb iapor qet iapor hxkhz dfvzig pedl ybyb";"mkgamxg xkniv meb hbzmxjn dhbj zhbxjmn hdjb";"ilteux pyutyfx mau lrr bacak";"sjjonmn dbbbgs crxyuu jztstgd ezb uiabyaa";"tra fle ufzlvf nnaw kec hiwnnlj tei wld iyt syk hjdczb";"qmd jtlud dgh dbanock fzp dsjgqru wwvo jwvxwgv xlemfij jcacd";"rpkx oxesil snazcgx fly miiyc ikmtmp oefyyn egbw";"ypfpeu wldnyd acchppb yqwcaw wldnyd turbz megci nbgxq xkc ypfpeu";"iqqv iqqv neui iqqv";"ypsxm icqyup zyetrwq nbisrv";"viommi toszx dpueq eyy cunjou ffcjc jaeez djefra pxvkj liudlig yye";"fhnacbg jghchh ghjhhc iue hwqmo";"vbjw lpn cizba ltnsfpz tzoweml irewlc uzckhpd mszal obd";"yeos utxkft hflxkfe fxczge qpgigkc ksgr vuumql vhlvv";"xzmkv xzmkv krecdi klpem jsbu nwcmik emfzxf cjmpgnj";"vtkjo pmiv zou gxo qdiyxsf hwyinjk jhkgf rjq";"dyuoc ywiyvch irfgl ywiyvch fxb fxb";"tuz onhr syu rqya abkaf bcfx mbknex juwoor zmksl";"oheg spjorx ksdy vwtq fxz phvtazk tcze lrxg";"hew lbup botaj ltr jpd";"dxgc tzinkej gnz hxvvub adsqmc dxgc asgpp rqbdcra goy pmamdua bhiacva";"xqv ygb kihxqz vyv pjcny vmyvsdv cgsi nfyx";"tqga ssshrw ndq qlbvwh huyd pxbgj qbxk dkkbf jxy chsobw pph";"hxl iwph iwph xnr otifm ljhre";"zlgvpd kapxpoc dve rklk ogh hgnp rbrmc zzkz hhmcx aklmo";"sar gfor nkf hek nkf aql shc aql";"dtcrw kfjzcjx qyhi bldson whwdayo mqtgt xhqzp ttqmg";"omspdml isze jdl nvwo qrkm wztfg ssfgyh dryj jhp unsmty";"jxt cszylng ifht ixtuna azoi xutqlv jtx tjx";"usgm azuayp fgkby ezpyq jqwl ezofj";"tnhvil nrvg moyrpqs sldx qymoff megflxh pyhqwms xmdw";"zomy zcquwnv lzx bvcna yods mjp dgsez";"blklyf xokd gpit tiysj yrwfhm tofx";"dtig vhdp omuj vhpd";"fogwxim qvdwig emdiv jvhl euwbzkg xvxb hwmqo ujdmlp epmykj";"sjxll sjxll pedvgb sjxll";"drvay gtzhgtx yrt okz nqf";"haxfazn pvkovwb pgu tgshw mxcjf pbe nwoymzc mxcjf pbe hydwy jradcr";"prjsloa ahylvj okbsj qbdcdjt pmfo pagyoeg vkmhjzt khzmjvt opfm xfrji gyjqyel";"lzypt jdbtrad ogr jdbtrad heink";"rcoucuq gdxewa rcoucuq whlw zhhm rcoucuq azaqohe mzyli rdvaf";"yuag ebcf yuag nsotg qqzuxr jfmao vyucw wmoye";"qwvk xemm hgqrr wyxkpp tojndm xlvzypw jus bgnu bgnu nklfwhs";"daqi knenmku ccm xkiuy vkexsbc kvvdagx umopitw yaocnx yoakqql mllmsp";"mrxgl gywit mfopia ncnsvw vdxek axuiot rsejua nei prndudz mnu";"egqn gaa qgen urs mix zbn rhn";"ewharq aihy udkdaob kgrdd kgrdd kugbjtj fcef llqb pduxaq wcexmm";"dwtiw nelq hppad algxgf gcc upou akm efnb mxmhrud";"yxqaa ups okbhgt iet qns tqn rnjqxgp";"npmhdm cgds ldexvr typi jyivoqk zkgq vfyxu xgfo";"dkwnmr umm dkwnmr okpjw wqx jpztebl eqsib dkwnmr";"dxbild wpbup evscivq dxbild dxbild geqp ojfbpl jshvqej";"cxdntxs csfocjd pyy tuhws teb boyloz xfw scxh pxhonky";"lteucke xrgwy hszgzu hnyrcvb";"pfgsgwg dxzh fworek qbstod";"usemcrf psczxu gcjtr brls";"hjol efxczux bqdn gvrnpey yyoqse gbam ndzyj lbwb bhzn unsezg";"bapw xifz blupk qqdk bofvqpp wnbuwyt rnwocu lzwgtt zucag pov";"xkre lqvd juf lqvd xio xyg xyg";"tzdao ztheib aymcf aorg iyawrch hetcxa iyawrch czdymc ccv";"ucgl azlppu jvxqlj pest";"dvwlw fuuy mnhmm okrp ualnqlm uyuznba fzyejk yaq crl ctprp";"odfq knox mkbcku pxucmuf lpjpol phl";"ixongh hfs ruorbd auy qyssl kykwcix aytsm rlj aytsm duq segpqhk";"izufsk wedpzh podjkor eamo vqvev ifnz podjkor xrnuqe";"twyfps bmdbgtu qye qkwjms";"wlav htym vhsnu cocphsj mdsuq vhsnu jflgmrp";"opajag itwjhfu purnnvk opajag";"hpkopqp vnj aialpt lzrkzfs nwucez nwuezc";"mcx hzcjxq zbxr dsx tpknx fva";"rlvgm xrejsvn ghawxb efyos xty wdzdgh olahbtn rga efyos vhtm nsr";"cni mbab qtgeiow ulttn rckc kmiaju jvbq emyvpew cdlxldn ulttn brhkprx";"eykpffp rapik qki fhjgdyu tome ehjuy bibjk htxd vexvag";"wrk dpxt gwkuiov gbkif ike gbkif pcd wpj toywyf qzsa aol";"yqwzh uujn ujun ujnu";"srs ralwxrz yxvvmgp sjhbhk waasid cqtxoxf whcladv jkmaq khjbsh dlavcwh";"mdvsjh xaj etvxlsy fxgiy rgjesel rlegesj ptriz ebdyhkp kugxm dxv egljser";"lhehwrs mqevb ygmv gri izop qgb ivm";"loqqam alojlwg hgen hbyw qlwpun loqqam worgnwk kope";"phozre todsknr todsknr ibj mvllsar";"wuripy ruwlfbh wukbkey qhq iishw tvtvci xawvxc vxacwx hsiwi ogq";"xryq vxwupqa zhqex aquxpwv bnvxrba dtbxki";"yvvwh zvsm vqskhp vqskhp ggqqlw bpn wbuv";"kqz tdy goqwge ygn jgd";"szjjhdk zkpoo nxexz ebicc";"wzuemcj oyd qupulju iaakzmt vzkvz";"nppahov umm wpzev wxkgfxd owgekp bhhb bbhh dgviiw kdfgxwx wryb";"bnc rhes lmbuhhy kwbefga bnc rtxnvz bnc";"ani mggxf mcoixh zdd nai hbhzl mes bdpqr";"mjn uinoty jjegvze bjgqg yhqsxbt coj obylb hddude xqi rhfbhha alood";"cbjzj drmihy tfkrhsd nuhav hihzx bvblqpl tdd szmp gjgfv box";"uumhdxd cmwgyf vepr rwqdkj exwk";"hwvr ydvw bqefu kghes gvbhp awms iqsqes khgse";"mrey jqfw fwvzhps komj dayvs fbui zmtd cofn mrey";"dsjds fdpx irjj usndok qcctsvf fgk wvg txwxcl dxs llp zyilwtq";"xmkelgk fdukc cye legkxkm wwly";"enlny eynln cccku brkz dpof mwfoxcd yftmnqh wpebvyc";"ggdn jnysl dsacffw ukj hdae cmzxku";"uqhm gcachmn kxndfrl htmfis jfnajz fiqiypr kekho kekho ndcw ckrndub dejfna";"keazuq ertql rauwl keazuq obmh rauwl ksrotm";"jppp poigqhv repfsje grjk xwkyuh pkx ayzcj hoxzv";"yhjw pcuyad icie icie icie hwcsuy wcd yihjh jnrxs";"gaug ivvx ceb xujonak hbtfkeb ttciml cctoz";"dggyyi dggyyi gqlyumf yasu fwdfa cbb nncn verhq";"rhgcw gpcyct kiuhbg kiuhbg gpcyct jlmleo nhumm";"wulxxu jyjek hclcp ogob viex wiqcupq";"tthu nxgzpid kcnj mss ukapgkp nnc bxjocv qwxs oejwsif aywqtu brahkb";"dtde bgvb smu vbbg zhlu";"lyo nwjjmep ldbok wgxhto wwuh qfgjknk wnsl";"lleyr onha hkwulbm jfg";"bybjwd uoxvbh mvj iqfpnxs bybjwd zqtszp wvc lbazjr zkzenja cev";"rbuyyr divtslq yuqmyt ajyveb smxsjb nlk tzqhq ims fewg wpjhr gqh";"kpewfd beq klilis klisli eeezut";"euqh hueq ldoo crqurv lvrwh tmaewp oodl";"bqi lzrf jyhvxfh bqi jyhvxfh nbztd lwpdn cuzi";"srjylou phavzjd wost uxkaq byh sluryoj";"ihrdk bcegkpq nygrs qbcq wyjg dvzme pgzhjl vibg kvv";"ijsx iedemek ktlz gtga tbal lbki gtga";"vmiaxn kefig kefig vngxz";"vrdmfvi qts vlvhq vlvhq dihmq";"cfz dyrz zlw qnt vok fwvahg skshbqf hbwozdc ntana jdb uflp";"rimbj bxemw sfps krtk umta vnk ewmbx nrlje ymrtqrz mxewb kjxunbt";"egnuti ozat eltl ngueti";"qtcwoxq rmaf qtcwoxq qtcwoxq";"zws gcoa pydruw qsrk lrkybdf ugr wkrxoj nyvf vitwn";"tmr hhd dojid zwrj bhsim righ keqlep flzunou";"lwoquvy acjowxk tqudk oenvioh nyavyl";"rgh dfhgyke iff cpxhuz hui koe iff hui dmukrei";"bjiumig lcbmbgh vleipx sfawua rnf";"gftfh qwb tfdroe xbno qhgofm vqfoe mux";"ljdrr gyfggai iun nju xrucbis mhrcrh fukr obvuqc whlalfe xrucbis nju";"nxjmjr egqwg arllu xqaahri lzc ivt uhsti";"sqiepba rcmts kvesv nvp";"tiksw tiksw rjni gbhvzm ctbq zuqfyvz";"ibsnm kfka aoqigwo sqouih rxz";"jmymq lxio adtmk umyu sxvzquq bporqnb heol fow";"mepa eckq rqviawv dkqoei ifmngpp jiava rtklseu";"yuycd jiufjci yuycd uowg yuycd udq izkicbr csxobh";"nwu tfsjavb rruoxbn oepcov elxf rruoxbn rruoxbn azglwth jcjm ksqiqpv";"dthfwip zqnwa zqnwa zqnwa";"gso wruece ufl crgnlxv vllsm dpyfm wpa ctxko";"wvpze seodz lpq lpq pmtp wsxs ffppx";"yfxquj phvjn rtwieq rtwieq kgxztyu vbjvkc prqqd lyzmdo ojbrt ojbrt qiqjz";"esaezr rpggiy jey kbzrhu uthus osr xxaiijd qfxlf auhzbx gkigoqw";"yfhcj uvgck cds gjhhrg cmempgj yfhcj cjb";"yxi voxvtuw unwg jqqm";"igvjr ljz rus sru gbjtjt qfeg ztu zjl";"leof ocxns hbkoysh hbkoysh leof";"hab lyxmf yhh qeks fwhfxki xmbcak okqjii nfgzyg bhtfgdj lpmjn";"mgognh tad herere lvwnzx ixwqs zphmuuc etdjz kczsf";"mtej rlolsnn zbl uykek dpkan gmz etxtgj";"mihuieo emjgbp jgks mihuieo iexrfw mjdnr bvp mcuzea xkbusvi";"jvqpj bwt jvqpj bwt gxr";"qpnd fpt tpor bibbpcg hmvguez wqc afl ckviua gpi";"dntmcg jglm sxtnu sxtnu sxtnu";"fzkbptw cbfwo ozvwov wbv gcdd izqo ovwzov lolewo xikqpw";"nkxyxzd kpn datf fki werq mwidqx oiibor zizcjph";"xvgyxym zor ijoy lvwsf fjuara idvvq rreit mqyyy ctio tzwqqhj rnpee";"maqkfpk maqkfpk xukg sfdmnlg xjopvr xjopvr irf";"liujcd vnlkouy dxkwc gto vhjvtw";"swhqhj cas aupsd swhqhj cas bvbooii jquck dtdm";"igh iqicicf ghi pcxt srcrjx gmf gyscphv";"drplj drplj wopgpnk wytag wopgpnk";"zexe ilcqoh qiefb txkuv lirfzv";"ovvpn ovvpn uqeurqx uwzn hgmucj ovvpn sjxulms";"rox silka irhsvym kutus otasof tdneav pcagds";"mkja omu tyshbfq onp trxs lxa tftbv bnpl djhnc zdqfs muo";"tjj rmmqas cbbkxs qio pikk ykyew gxlxt nhsyl ykyew";"frcprg njrz oaxcmhc qben pedm ecvtga nzxwpb ior gaklot dpem";"zyt kncau spoe qlchg sqys wkpbng yflju qlchg vkve bzadbpa";"qtq pkaicl qtq mfkfqvr dnleiq brrjxsx uoyxh pkaicl yvmlug";"firwy imtlp ywl qfa dqrbazz ztzb pcsbwhn zesmlag";"ivey ivey mtvc mtvc";"lhize acwf moa cdeoazd voktshy qmvqq jvmuvk ljfmq tsanygc";"xreiqkc aawrovl pofcsg xreiqkc xreiqkc";"cjbzvn ozds iniqu sdoz gqmki bablvll krs vjzcbn";"izsod htkeqz entxn qtns prpcwu omfnmoy";"kwfb tctzda aztctd tadtcz gyt wunbcub ydiwdin xxk";"epnl ijcp giq ltfk zjcabve zfksmz epnl giq xxxbsom";"ulyukpa mdjsbn dydko uhkdt qms aaaj hustlwu";"zlsbu ohx jcwovf egf zlvpqgx qhejm wrywdmw";"uhxqrzr mmu kjxcalj unuohiq rri yzngnb ikvlxry mfiym qbksdx";"khqciz som yklmm jceb khqciz jspy jceb";"ncwggv njvi nqox krtsn lnm";"bgtqme xaxcoq qbtgme obqual vorfk baoqul lgrb";"jli tsbb nlxjc pkwzmz dlxrj hmho gzguko ilj iyaasm";"wlmw grkumg dynwtyo emxhhqr huluk slpqu uhqcmd absmr ufirmwr";"pbs pcammxv dplfr tzvmav nccyy blvyq ffhnz bccutq";"hgge ghge vxmvz hqxgjdg zab guo gheg";"ylj bucoyoq udndc wpgyrbx ueh udndc gxdsdh hdoz wwgqlg";"cjdeh gttyqe kdkm ltzd lfeozse quvjq mnwhokm kdv oojxm nxt";"mfkzus knqxt saxkqww njx zumsfk sbmcyad cpt agvbuv";"tukn vyco yobvsn bzgnn klrnzy kea thzk pxpwq ryfff nxzm";"ylbm lxlz lybm lzxl";"wgtxoij zad slgsi cvnxfg iomswwl vmx";"hkm yinhnkj kmh kwkw kayknck chur styjif yknakck";"rtfwhkq rtfwhkq zsf zsf";"sldq zlntr ueegiw kajivqc ozcbm ceft snvugom pdyc elppeed nnqrp prwwf";"lhk xjonc muc tudag tsafx mmivb dvrjbp qgrew";"hnzer fbgqp aazta aazta lxaz lmgv aazta";"victgxu victgxu mlpd ummrnbx cazjgnw isxcyp efy zfa cyusj";"gyojxo onzq gyojxo uxufp awi ilhl wefwfxr gcjlt tmliynw uxufp pdcnxah";"wjwachn xkuhfbp oky oky ybaeqkr rbuix yreoaw wepmye brvon aasb";"kiidorw vxtxiqx wtqvbrv efdth isel qbom vcssyc vxtxiqx wtqvbrv riafzsw mqzsj";"eurpjd vkhdamt tmfx czeoot hiz ykz lmixzq tfur jhzr";"ipuftpj qbll sqkkdw fwncmiv bri oeeh lehd ioh wag";"suima nanngc imrmc krq atxdo woy atxdo akev qlr aezco qlr";"cfc efwbzck ozkmcxv moczkvx ccf";"bnekky iakrk sask uwgnjp iyi rynev bdnas ldh kass";"sicmw vvjbvv cap nsumc xgvrlm wsoo uoqdu psykckm";"ugg mtr wnzhmmh tjxc ehwnji lwhu mdsckk yvmk enubrqo";"grb oxmxz ohu ytetedv ssx apzlppg fdkamm sxofc jdt ynmu wyejok";"umoep rbyqm eqfk twqnog cptbbi dragna ngqs ffb cexxnc rbyqm";"utizi ormkel wvwur bdx ecelqbv xiccama aag glfvmj";"znb rsuqoa uxo svc";"obs lbifa cffi catpd";"qkxwian ajlzjz wewduzp bbyv qmt fsr qgiu epinp ghmf";"hatg bfgmb aght ghat";"kuq inp dun cknbun wmwsu drlmmg kyxc bdl";"bddybth swdbf jhi fva qpobio bjwm wjaztp jywi";"mgckz vhveu zkemhp zdf xtiqqew mlx wazgd";"umbjq pya lvvxf jeavij rhrxvew bwjqgpr piz";"xaycpwo vjcuc qksc yuixhni sfbfb dydyaq gdfvb tggg xidphvf bpjdrl goskxym";"agxfoip gguif wvo agxfoip ntkbaw fbyggy ooft zxih";"nzvsu ffwq uxvfbl qrql olhmhom qhdltg ymwz krtndtx olhmhom nfsv krtndtx";"qdp jqk ustz xjripzv mnk grnodk pjwdsj uug zqxjqj";"mufrcox zunisfs ocvcge acamm xua vor bsde kxr vor kxr orccxx";"ncycbp anvcxay bmm wndmeaw oso knmk mmb wamenwd kmkv ppdd";"motdcn xzagzwu vuzt utffrn yuqxzrh uvzt ujttq";"tauoqy coiy ybesz tauoqy wpmr trquyne ahxbj jzhems dsdy";"aczq ypw pgmzz srfn quatjgf";"cih ypapk bfxvr euvhkk gugru auhqui";"vyf pssgfvy dnhvbfl xpacme dnhvbfl mzdv iynq hcqu";"lbzvbu hhxiq hdfyiiz iyzihfd xhqih uzdqyxr";"iapbdll vdr cprmrkk vdr dfjqse mlry flpqk vdr";"grrfkq xcpxd grrfkq dxc bjpr prvwh swoc swoc";"bopo chvwuhf qhd ieesl xey ieesl fnjcbe";"kic fyq hsucnu agwyl pzzmd hqksh psw";"mxf uau iti lcoz lpg zbu ocre wqlocmh mxf nidqj lcoz";"bypmix ptzxgmf xmtzgpf hrvzzq";"lbfw zwusma lbfw tuyyy";"lrf uej unswvh obgsb npbl zajr kenea uej qnyjcu wzufim qpzkgya";"qcrxj llyu kligt hlm ehwtbx dda lgsvhdt xewfcv uikn";"nfzjx izqdbq mfbxs imiuc yqxb xlmvix izqdbq eflqfq wku omgtuu izqdbq";"lasdwg hiy btzt eefd eyoep icn nnmhg otml rek luixac nyzgn";"vekteds utsuxdx utsuxdx vekteds";"feyov qrij zbebwg ijrq seplram wttkwm zewbgb kzuhuh";"dmkgtv wohgqo ddtqmv zatahx mym hqowog tkmvdg";"vhha wjrmuyx kqh vyyrj xzchbi ejsdq orlxg vyyrj dlrc";"yetngqn zdtuqox hkarjei fqpsgh eaqwbg zsssog ghb gddqqzr hbg";"obldb zsrhz zxp uxphnev mwnbc pfjft fms xwslk vjm fxy";"nfij dbfykv ttq gyjgac igxuyqi gtiioqx ilhdex dbfykv uyp bdiwya gqf";"pffzruz vogfosh dcs wje";"pohhf fhpoh oon yyz";"xxuam afwm qxl lnt syyr bwxhhf sozauq shlhfmz kwnn milav ochq";"wefcqrt gejw cwerqtf fttf gjew";"jfsvnmr osca epwtle pgfif sxom";"exlfzmq nakp rgdnx rrcvth vhrrct aajjdrt ryyg dsozd jdqlqj pakn iruv";"rmcvo txszcs xxhyxz hbsozk wshkocf rmcvo rcbnt";"kitz yjgney yvkymef nauj hmllsgl kyhm kqr pzsu rcf pzsu qpte";"cdinpx bfur mkj naz ihkheyr nohhoe";"ylris xeqcgup wap bbfih tgfoj";"ina gnlnm zyeqhij cudfuf ipufae bvkdzni aat teqsg cudfuf bjokrbl teqsg";"aedx edax dnfwq qndwf";"rdngdy jde wvgkhto bdvngf mdup eskuvg ezli opibo mppoc mdup zrasc";"qcnc iaw grjfsxe gnf gnf";"zbjm snznt zelswrk gkhlnx dqxqn qqxnd dmro";"zisecvx ztezof uzbq otnrtj qsjzkwm ewvcp rlir bfghlq tgapdr qxmr";"ipnqj opjf vabyoe wkwnd";"wyf mfqxnrf apm snarf jqu aaghx pwecbv lvghayg";"acncv jmmbwlg oiphlm ifuo cvt";"pvmb egansnd zmh gcuzzci rrxpslv ubith";"uoleptg xbouzn xbmg cfh cpn wpqi xbouzn xtxis sxzpns";"rilybri kurbpq vfmjpck tjyogho hfyxad svfofx lfbbhxj khaerfs iqr";"seaebgz wlmtkre qguv qguv wlmtkre";"sgo edkxya zdqgwtt gxu nibuu rairqoq mzxli dci qsv";"tsol mdhzqr rmaqnru ggvcq arbwkn hlkcnj ljkcuof";"mmliphp ocup puoc eijjv";"gmajqpb ijki ijki kvz";"pmqss unhlpcj dlkll nuhlcjp expe tlurzmv nsy vlumtzr tgseozl";"gkvaoni hsba hsba viuedv phyoclp fdq phyoclp febld nqfs";"rxvdtw abn pntv qrqfzz slsvv abn lrxix mnu npot";"ghlfjp woy xwkbmv bkahpkj jve cncvk jvdype fwgvoju yrkwjp gwfvln mvkv";"kmluh mie bby fwer chsinb ojglqr nqk mie";"yzmiu igkgca ybnsqja jpfejtp yjddy xsosxfi ingx qwuhb emrkwpx idqjmmm";"btrllw mphm dkvo ewdl dchcul yah btrllw kmqi mtvgk wtb";"hxsgard yuikc lykt tdee adprp gpougod klnzk mzsmlb";"hdn znblw ifoblur bwzln dbv";"smofpbs vjuyiro llk lfzesga tybu tybu";"gffnpug xaup iqiyz fjkpnkz drrk fwyxw lwzfskz gslwpmv vjxylva tbkyo nib";"evydmb nhwuiiu fkerq nkgbuyy uclrs ydjgglh xhotwbm riirgzt";"bsub eavbt uvd dpzwyt rhn khrbptt xszckc djnfxju axofhat powmso nvdffrv";"xtuykl fjz mbikc xpnx hmey fjz fjz";"rkls nwdcsyx rkls rkls";"tygml untequ ybdfumz nqffbq uipc sove hfnqj";"ytecew vven koqn royynd qsn ksl qsn sdw";"hknlw qwho whoq oqwh";"lzmmtqu qvhyeo cnofuj utpwkjz gnirz yhhu aodbnd";"zsr axw kwtzcv tydzo kwtzcv lkxsm";"rbjtqe nihifd gvdxd bpxzy rxteky vgcgllv vbbua anygiup rqo";"dpd wblfwp wblfwp wblfwp ygahc tqjbaq";"gsw gsw pacgj xmrcz zmxhmch xmrcz";"pdq rhe xqmq lgpkhg fyffrot ovnqh wle";"tbjavke ypzzrj jizx gdxoh icjsat otfh fmygumv";"snch nxlgjgp jeyn sxoqfj jtage jtage iuice";"rtb coefuj grwg grwg rtb krhqnma vfhgbr";"vhegtl btorwxg szcev kbvkx itsk nlzpbed";"hiukrf ilzkm yllhh xsgwkdp zyy kjbv";"rfcg tdorci zcj wzftlv rfcg rfcg";"lgbc lzizat vsno pau nvv vsno bbr lzizat qhtb gwp";"sfwnio tcugjk bsfsz ykyfwg ibkap fsrvy mygk kzunawx zyhyh";"mpavlh qps bylh lttjkz rqabgk vewb bwev tlzkjt gzrbxga ktmso prpkj";"gpf ims ynh ffrs vpa iemp gofh cgbauje";"secys qks mcnfhwh drog kqs pajy zoltkw lfihnb myb ioxptu";"ytq nrta ouk ajqblf yuwwcd zdy blyoxbw dakk nvgi bzrhzaa";"nkoych sufiia xkdvw crtldee zycl qblab egqhr qblab";"nllno muxaf vds qjnitmw zkpj wskyhft kmqct xamuzpw qcai cdjtbt kaxv";"qzdytpe osr fuw osr qzdytpe whperd rydwdcl knoa";"zkdznhd peh duoygr zamrgl irnvj otpe pltpq jdkecg";"byzgw rece iigdug ehif tpgje";"ccnn foqdran gbctca tefdjxh ntcr rjciii xip xlss crl wvvhzqm twyohf";"dqyii milqqc qjgkojp qjgkojp ryde";"tdkyj tbrcud tsba vqtmb cjwxnf";"hqhmq wemvrce nagig pwnw nagig epg nagig vlsi";"tqgvw luoplw hccti npjm rytdruq cylrsun rytdruq vjsbjl rytdruq ppti";"itgt tuwc itgt rvp itgt tigns eipl ksmru";"pdw wdhtkn nbdbpn wff zhuuipg rvemv qxr";"qgkwdq cjilayh ymeks mrpuzai dwgs stfstgz ucvqhb yout oiq";"vpxik ypfr qytimvu qms oxbmw ppyfx";"fwwidn gdhd pyuexk snsz iwndfw";"lfcb sllxjna lfcb hpzahfg mmvgaa svny jhuzd";"unyg gicmzd fwc spkciy toyq wjupckd vzzx iuqgka ytqycb pxsufj";"goj tnrcml eyizngj txa xrkiw zvu igduz";"wek xrrlkna clyof rrlnxak";"cjm rmyuku vjom gtf";"buk cfae awstd dywgqp hxo wcxvf laihqw xdqfes wdbh qceh uzlwj";"sudguo dxwplto rlebdh bkamu dxwplto";"crwkyxm yuz kjtdhom crwkyxm";"trhc sduorxr aizfryh rsudxor gbyc";"pczkyl bptp qnn nxmpwsx udrg hhlb rubtrmx twzodlp xygnht";"jmqct cden yfajtkz fevcw sxonbxz sxonbxz qkzkm hhngr fbv";"sdsnm mwvicr wypfi cty ndbowr woiz mrauwzd qlno mwvicr";"vteyo fng lvr lxytn txpj milg";"wjx ahtmgo cgwcaj kaxae fhlvlqf";"ezj eetqhzu upwda iiefwlk vyvby";"imalvy yeghqe jwcu mvrod cwju";"bxnmsa yhfu npsdar tsbri hfuy sirbt oofxmy";"fkndt elbjtn vepqtxt elvpf fpelv bzkgag qttexpv prblwb";"rmq iqs yvprnyy iezqrzm wlqsrr";"yviovq lekxghj oey qwhzj lxknxw qiyovv ksnt jptz";"tyrg cifxt hugqf tyrg ffuiv jmax qyw fozfosq ffuiv";"nmg rsl jpzazd qbtlf yxqtsj czwmdfd bamge lbjdof uqy jssc";"cbx boozjip pwgvzlq rjz kxy kxy hszacok fvsq jhnir cnsba gafz";"sbcuxb wfur nnnfqjj fdwg huhe sbcuxb";"icwk qelbxs uevp qped zsnhh wpuok wddxsln ftnzupr ruxol cgxjb jbhh";"izcp htykj xxmndoq amnspe htykj";"vverol oixwlny vqd tvfzu henc gnyrwr";"ytxio etytsx choynep zqapo hfjit";"lkvgr oyzfa taiqr jok djatvy ckif tmdw oyzfa zroy";"jlgpyp kkqysg oqjki hjohoug hbhta muilz zft";"sumfyu wftcu bwwdcy lezimwa qwvxv zwh mqyv bmfot aii torcol rnt";"tpdj xrw ccsbnh fhptv fwkxjfm dmqaokd bjci";"zxi vmf vmf dpyg";"sfzxysw lcms bkojtv bkojtv";"opywo qll ipkitr mtwp tudrr svhyp huz bxsdpn xomfy";"gkod luo qrosbp orbd rpsjzyd rlh gdok tze";"nusiuq nusiuq zeys ahufexc";"veno jntg avtmtdn qojxru zegdcql odfcetz pgehau";"uqun vigjm ykac ozlelj danmji bibugox";"rpuozh ajwru rbvuevv uhzsq";"iawoe tyb aewio ymf byt inijv ctu fcys micsgzl pbby alt";"gktyxp ris mqpfm bkqsfl nrg idbbcxg jhcf";"qibt invvv qibt luitx rnm eby hrfbmwl wnap sgkzvb qlwc hrfbmwl";"jwkv qecsjbw lycgldd wjvk tjcp dycldgl pzrvr zrlcf kji";"nzsrmiq nmhse ilivrk kqv";"besmyzi imkgpt iekbjax abxeijk uvzs wwv";"jdocl uki ltswp tjkljc ymce iuepze qygqxzs tei lkry";"hhyfy gvzd mqksxlq czn afe mesnag eep frwgekg mqksxlq phpy";"ehg connnza ekt ddgokw";"mpbsoms uzhzl xevww ztt uzhzl";"lftybr firc awsud dsxdkk ltf ipjv dtx lcymth";"vkcpb gxtxq yioeq fexj xxgqt";"srvca fslnnvf nfmkpvt egw wemumq jie vznf dzsjw cukf kcvyir";"yxjkl lyjkx jyxlk kgc xtz";"tpoe xzov csp leleoqo noyre tdhf cyib sjgtdx raehdw nmcxp";"qvt uhznqe bpvos vtq ddlebtd tqv";"xlw utsxs gpia rvlvnts elkxr dddihy tnrslvv ibf wlx bxg";"cwqnnrt rkkqyf dye yde fzl pthanj";"boc rqjenpp xjqte jteqx pvoofc pidqe ruoucy gvnro ognrv";"qhalb gnazwc fhl iuti";"clnbjfo nnfs nnfs heymvr oarew oarew nxu";"lwtrotg hiaxwj ymzbly nvhzjhj zlsaheg nvhzjhj ymzbly";"rrvi tsjp tsjp tsjp killji";"rpx hiclj cmwq ibhj nfd";"pvwymn iebkd xmpw vuhhkap ksw zigzy mzzyyxy rmuh iwwhea cglfq";"rlwelgy sffml jin qsdzro xlsty mgqzuu etxjuo emzd jgnoyq tkjuy vfvb";"tkctdj hhkuc viskmy obw";"zvjkuj akeky ikj jqd hfhzbwe bkc";"btev nrdo hcyiuph stf qharfg vpmel mpfz nvs ytgbbc";"ieepn ndueuw svmdr tcvumw mceyrn mrjwhyl tbdj mgrgvz";"uxrs ckyi xpmqm czzrkl cjp";"nlliwd wrqkrkz yjmng nlliwd zirde hcjjn wco ysf mgl";"dxti lcahe ommare izlwf ramsfb nzgfvo ijvm fwymrdu bndq";"isxy jpvuzu tdduyhw dixp cfa fkzbteg ytoi kepk ysf yqcpi";"qmeprfj soqo ncgeor cqsuuj grzy wogxy vyblnbg slvtry vdols kka";"ltykfp gtzl olrp gxend vapee deq";"emywfbn dbfiut rkt wvwe dbfiut bwffhea yuzcxv gogpicp wvwe";"vqvmrp ofbk dlfabd jwllzxk obx vqpwjj umvng tqwis fstxy fstxy";"miha zgvyux rmraszo xwf";"kjaagk btm kjaagk wkewjrg kjaagk";"lbmli aizs omrdr gzktnx asiz ptanzpa xlo ljre ckyb wob";"svz dlk rijagg avxmg fkzwhk uro gegm";"dzplum temdw jqnm tvxcww bmg tftttpp deuw comxey xfimzjx caluczi nqn";"uwvhxa ztkd nlsdyt vihl julkwwv uzch dwakhs";"wkhuihh ycrc cxff vzcfhpp uegfd gaok kcnvz lhzogq lwa tyrypvu";"idp zmrrzp zmrrzp nktp xsnx rjsxn";"eybrnib ivgntl vaxsbpi eybrnib";"nzvnq xvbfa pbhwwh ylju runvsj imlx vztesn";"nfdohd nfdohd gtevnky pivjyct ihvd fzcsrq lko fmqk";"kwpkks ecikxu bcxswlt qvrxm sbcqmh";"kdjrmj piuh kdjrmj vnaf gyedkg vptxgm xezssxx zsg qjzpo zsg";"oqo sley aqx qmpqb fgmylbj egd zivj kepxizv kuakyn lunbnd";"hmcf hmcf xlhgc hmcf cdlm buofnx";"onjcj yluonz kzmk phqo phqo phqo";"ohaafy efl bnkkjww wwjnyoj dxeaig ywnjjwo slk hrbebw ohlyju elf";"msohiqz aunk njki bfktdgi htmyrj mgx";"numlzrl rmnlulz glb ltt fhbajz gqxpu";"gko hco oai ryq xwy sdqosft spjkiu cxfhg ycwpglh noy rah";"btzpjem brpk vqr atxu rhlh rqv jmg fvyus";"phmxxgj ejx xje qtk hsb kqt npwj gqt";"hujyjp nwmsd ant zipuya lrkahww uwqal vzlo qmbo twkjkse ufivi";"zfbnyz fwvh xrnrw usn zin daq iwjzj";"yykyg iwypfy hehqnl cjvk cevdrec";"gui muuto wsta glqmx gfo rdmbv mxwz gffzt eejpw gion";"lpng nduid iqbpu nduid knrqd";"xwxn oefpckv gjaua ugaaj gjuaa";"qxk aeql trqdmqc crzlinj crzlinj trqdmqc rijcne ewyf";"rfv qmbe fvr bmeq";"upqyfw lowzq wpen upqyfw gfskbil sljuzh wpen";"bdcara qyhx rtaez qyq gbyr";"evzls qxtxq clzd svbgqi zxlzgss vtrre fko eebo qjyl";"zaapeo kpwhz tygknau nyd pch trp xqe";"ypzcafg rnqmbh qtteg sncu ssojhhm zonfym thir xmgheb wqj gpjg ssojhhm";"wvcwyn xrf muozyya lasdp xpjgu kpqv zkiihiv ifje cbdlavg xbied hfnaa";"qqqb rettz rycukl ihpkhh";"dnxzxqv znb znb fbxj azxtezb xvxa";"peqkd xlzqkov esgnw ucku hrwpfxd xtd vnig vlmfp ajte qswr kqoj";"dpwy oavzkk dwyp ehij upqxgii pydw";"amfc hfv xmqa nqvn cal rqmcq oej amqx cla ntxj";"hqhhe qkbhwli wmhlcq xaczs peywuo";"vcr xfv xfv kymo qpszwzo xfv";"nmrbur tswo xbo ljlrzo bmhpgc pev zovkznz lok wbbhtkk";"tojj lxqgr rhjavrm ndsdup gdbjwaq cqpnl wfaxivl rfry ryfr udspnd";"beffod sknlph amb feobdf";"mldgn jxovw yuawcvz kzgzwht rxqhzev fsdnvu vluuo eycoh cugf qjugo";"tlnd qcxj ker fdir cgkpo nrqhyq raef uqadf iahy rxx";"mhvisju lhmdbs tcxied xeidtc ujry cditex gvqpqm";"cgc jazrp crgnna uvuokl uvuokl uoiwl sknmc sknmc";"rvbu czwpdit vmlihg spz lfaxxev zslfuto oog dvoksub")
sum {.[=;] (('[count;distinct]);count) @\: `$" " vs x} each input

p2
sum {.[=;] (('[count;distinct]);count) @\: `$asc each " " vs x} each input

D5
p1
input:1 1 0 -1 -3 0 -5 -1 2 0 -1 -3 -9 -5 -1 -9 2 2 -13 -7 -13 -18 0 0 -21 -10 -2 -12 -18 -4 -27 -24 -16 -10 -24 -12 -5 -31 -17 -10 -22 -16 -3 -10 -5 -37 -16 -4 -8 -1 -44 -12 -38 -42 -27 -9 -52 -13 -12 -36 -26 2 -48 -2 -3 -17 1 -51 -47 -68 -42 0 -53 -47 -34 -17 -15 -10 -76 -53 -58 -24 -62 -78 -11 -5 -71 -52 -41 -84 -57 -63 -88 -11 -61 -55 -85 -61 -87 -57 -46 -94 -19 -31 -84 -60 -7 -31 -25 -90 -108 -79 -25 -41 -96 -88 -3 -67 -91 -28 -19 -103 -88 -70 -18 -64 -59 -49 -88 -110 -83 -68 -17 -61 -33 -88 -29 -56 -78 -20 -108 -45 -46 -51 -59 -1 -92 -40 -101 -131 -141 -59 -35 -26 -14 -22 -52 -108 -47 -70 0 -125 -88 -15 -80 -71 -23 -125 -54 -100 -155 -105 -114 -151 -97 -9 -69 -88 -31 -165 -45 -146 -101 -155 -75 -60 -98 -90 -125 -19 -97 -166 -12 -55 -99 -86 -42 -111 -189 -134 -36 -3 -103 -10 -32 -135 -66 1 -37 -170 -194 -60 -99 -211 -68 -73 -107 -102 0 -11 -110 -202 -136 -222 -82 -137 -11 -121 -47 -49 -115 -7 -208 -102 -86 -176 -84 -107 -133 -17 -71 -103 -112 -184 -104 -22 -129 -223 -63 -11 -199 -142 -245 -157 -125 -160 -111 -209 -229 -88 -233 -137 -149 -204 -223 -93 -198 -123 -167 -250 -166 -234 -114 -1 -265 -144 -86 -65 -32 -131 2 -156 -217 -199 -27 -134 -112 -12 -39 -17 -223 -117 -44 -102 -201 -21 -156 -8 -5 -266 -133 -63 -279 -296 -92 -154 -100 -10 -123 -293 -66 -142 -128 -28 -175 -166 -70 -203 -38 -61 -50 -10 -25 -89 -98 -233 -39 -295 -105 -29 -36 -98 -67 -92 -229 -173 -216 -78 -331 -319 -296 -112 -151 -212 -65 -124 -33 -310 -11 -22 -32 -227 -23 -2 -208 -165 -217 -22 -207 -203 -277 -49 -342 -23 -148 -191 -42 -348 -90 -161 -190 -93 -337 -329 -276 -285 -327 -134 -366 -132 -310 -93 -244 -306 -197 -77 -353 -80 -337 -369 -353 -2 -330 0 -212 -167 -318 -61 -272 -369 -51 -294 -363 -92 -260 -146 0 -351 -154 -194 -30 -74 -155 -226 -21 -316 -20 -326 -105 -311 -232 -223 -250 -35 -308 -14 -93 -17 -422 -354 -377 -283 -413 -19 -245 -152 -179 -173 -97 0 -406 -176 -97 -402 -76 -236 -444 -233 -38 -33 -362 -190 -15 -267 -163 -240 -272 -449 -163 -415 -416 -1 -12 -103 -150 -238 -464 -461 -351 -64 -198 -318 -246 -157 -449 -401 -39 -382 -269 -389 -209 -241 -177 -156 -157 -141 -190 -470 -422 -447 -111 -463 -400 -334 -323 -188 -249 -380 -141 -120 -391 -311 -26 -460 -438 -18 -127 -133 -201 -429 -391 -99 0 -335 -373 -367 -463 -224 -390 -299 -233 -411 -244 -5 -73 -377 -413 -172 -497 -120 -87 -262 -198 -112 -162 -446 -469 -111 -364 -284 -252 -212 -358 -507 -48 -74 -96 -518 -34 -290 -234 -472 -294 -5 -334 -355 -462 -334 -494 -549 -121 -482 -548 -14 -340 -410 -441 -559 -282 -384 -88 -453 -323 -465 -483 -2 -481 -333 -483 -176 -250 -167 -312 -550 -185 -365 -108 -17 -326 -488 -440 -122 -505 -465 -54 -241 -20 -397 -48 -44 -187 -548 -174 -461 -238 -581 -409 -582 -140 -191 -60 -147 -538 -5 -116 -62 -165 -334 0 -578 -264 -396 -589 -354 -276 -283 -238 -616 -202 -59 -529 -346 -196 -247 -247 -622 -523 -65 -525 -563 -210 -211 -569 -340 -391 -211 -324 -515 -234 -241 -576 -478 -392 -307 -202 -648 -485 -460 -22 -42 -383 -440 -378 -340 -303 -167 -608 -92 -167 -217 -355 -126 -669 -576 -7 -568 -526 -577 -163 -566 -561 -217 -413 -275 -225 -472 -626 -667 -21 -179 -299 -204 -73 -172 -8 -373 -344 -551 -487 0 -154 -658 -145 -428 -589 -116 -266 -174 -109 -148 -471 -120 -623 -455 -257 -486 -677 -51 -63 -531 -326 -180 -321 -460 -652 -542 -225 -574 -362 -195 -422 -200 -479 -302 -573 -652 -543 -77 -202 -96 -265 -717 -715 -587 -710 -135 -263 -61 -197 -426 -10 -675 -465 -58 -525 -432 -348 -378 -474 -22 -497 -438 -612 -67 -235 -255 -236 -566 -386 -604 -366 -16 -105 -713 -697 -138 -743 -405 -744 -168 -754 -627 -201 -38 -121 -252 -240 -756 -350 -678 -507 -780 -647 -136 -644 -404 -722 -680 -326 -421 -105 -792 -407 -672 -179 -250 -59 -761 -775 -103 -779 -682 -278 -689 -735 -738 -498 -28 -484 -36 -482 -310 -397 -437 -229 -744 -699 -470 -371 -115 -766 -147 -182 -646 -540 -40 -202 -322 -289 -828 -784 -121 -366 -220 -36 -646 -567 -301 -168 -26 -190 -138 -390 -130 -448 -242 -274 -65 -784 -319 -179 -332 -327 -698 -837 -691 -113 -251 -143 -755 -791 -725 -849 -194 -570 -449 -186 -354 -524 -54 -846 -516 -325 -515 -453 -703 -530 -1 -869 -401 -503 -641 -822 -694 -667 -537 -285 -711 -73 -746 -764 -737 -475 -476 -456 -845 -556 -737 -524 -869 -646 -898 -692 -97 -248 -32 -884 -486 -113 -348 -517 -417 -39 -726 -580 0 -858 -370 -672 -726 -599 -475 -87 -336 -384 -619 2 -235 -629 -774 -905 -727 -232 -389 -626 -240 -780 -392 -900 -911 -592 -625 -424 -274 -231 -327 -714 -729 -537 -526 -8 -468 -809 -566 -786 -798 -245 -958 -652 -610 -703 -207 -727 -930 -883 -959 -204 -976 -568 -121 -503 -910 -134 -619 -558 -340 -24 -16 -780 -797 -594 -441 -886 -420 -639 -979 -711 -745 -916 -152 -700 -116 -523 0 -756 -194 -609 -151 -14 -133 -768 -630 -917 -46 -60 -485 -201 -440 -386 -101 -283 -980 -144 -337 -599 -202 -776 -470 -49 -278 -270 -21 -409 -84 -562 -191 -53 -390 -300 -706 -284 -778 -714 -632 -702 -375 -903 -1019 -475 -353 -950 -410
a:0 3 0 1 -3
f:{.[{if[y>=count x;:(x;y;z)];(@[x;y;+;1];y+x[y];z+:1)};x]} 
f over (input;0;0)
p2
f:{ g:{if[y>=count x;:(x;y;z)];
		(@[x;y;{$[2<x;x-y;x+y]};1];y+x[y];z+:1)};
	.[g;x]} 
f over (input;0;0)



D6
p1
input:4 10 4 1 8 4 9 14 5 1 14 15 0 15 3 5
x:0 2 7 0 
x:input
f:{v:x k:first idesc x;j:count q:@[x;k;:;0];q+neg[k+1] rotate @[j#(v div j); til (v mod j);+;1]};
g:{ 
	res:f\[y;x];
	$[(y+1)=k:count distinct res;
	.z.s[x;10*y];
	:k]}
\c 200 20000

g[input;10]

p2
i:0;{i+::1;f x} over f/[g[input;10];input];i



D7
si:"pbga (66)
xhth (57)
ebii (61)
havc (66)
ktlj (57)
fwft (72) -> ktlj, cntj, xhth
qoyq (66)
padx (45) -> pbga, havc, qoyq
tknk (41) -> ugml, padx, fwft
jptl (61)
ugml (68) -> gyxo, ebii, jptl
gyxo (61)
cntj (57)"
rows:"\n" vs si
t:([]name:`$4#'rows;weight:"I"$2#'6_'rows;links:?[1=count each ">" vs' rows;count[rows]#enlist[""];{trim last x}each ">" vs' rows])
t:update `$"," vs' links from t
t[`name] except (distinct exec raze links from t)

input:"ifyzcgi (14)
axjvvur (50)
tcmdaji (40) -> wjbdxln, amtqhf
yjzqr (73)
smascq (97)
hyehtm (7)
oylvq (136) -> witry, cvlod
csyiik (34)
zivjpfo (23) -> lcchgb, bhqlq
ggfmiv (94)
vpltn (41)
gzxnn (171) -> mqodhde, djvkd
bsfygp (75)
dnrjb (9)
ohdnhx (261) -> tgiou, lndczw
frcrd (56)
cldaag (31) -> orbcuzi, teyakvf
vphlxz (26)
nljmcv (47)
xcxqa (6759) -> znely, rtsbgwx, hilafgl
hywzja (81)
ytxcti (60)
igzvp (68)
uzvsml (34)
keusrg (27)
tlmfw (45) -> pehflc, lefxyzt
hjmtrw (6772) -> cblhmk, zzflc, xsztla, iitbuxz, tckyc
ahjlf (1474) -> ejvipa, xhzyzer, pzwtjfj
egszxz (14)
skmuo (1607) -> rxsihsa, vsslzfp
ifyja (32) -> rvixnmq, aumrixf, wbenaek, jkkwtd, ywnsmem, mmhtyd, xmzzrgs
dwnokzu (311) -> xinfpy, lwvfsu
txbgfm (33)
roqfxg (62) -> wrhnq, rskara
autjn (29)
hnedp (10)
owxawf (60) -> twoyl, sikmtaj, lvptmrf
jensj (281)
sglkjsh (66)
eeziziu (34)
qjuuu (83)
iebulx (297) -> mqcflzv, nafrmeo
lhfuku (159) -> syzcti, ynhvfvx, ckegba
mxnlv (61)
emtjcx (60)
jspui (58) -> chlpx, xjkquk, afyxhh
nmikggy (64)
vatflrk (6) -> uxbhu, gekygl, xdyrvy, wesoooi, esphpt
jfcoc (41)
gyepcnc (6)
atbiby (80) -> aqtog, qjsvs
ygnkwn (52)
piexct (65)
uitfx (39)
rdvciwk (55)
jkgnvbn (23)
xpewzk (45)
vlqyxe (337) -> rosfnb, vphlxz
bmdgthp (215) -> kyfuyaf, tzrqqk
czafdho (24)
emuwzd (102) -> ifyzcgi, edotax
fwabsk (14)
uftnfv (53)
ndkcn (39) -> mkjuq, ghcgz, cxpwfir, lxwvf, nsghrq, vyvrn
srzfd (77)
gqhnstx (870) -> xmedt, brzucfh, layqazp
bdnjn (57)
pbckxv (14)
fbpbs (74)
zwutlym (92)
lzeud (290) -> igkrktn, oixlcn
gjctf (27)
azmneyd (60)
wbenaek (253) -> gdunxee, vgiqvsi, bmlkhaf
orpjw (72)
dgyulo (9)
qklqozd (125) -> otikjx, wuvhyc, dwejsn
waiwj (47)
bnevesk (256) -> dmglcj, blnwcb
yqnjd (50)
vvkkkpb (39)
ciprksz (84)
hblux (91)
dfywz (60)
jeiqx (26)
zdissfg (7)
mriqcjy (66)
eydak (49)
qwxwd (49)
plhlj (64)
nqgbp (67)
ewwfzg (70)
djzjiwd (44600) -> zszzkl, hrnrjrt, hjmtrw
mtflvu (71)
shesfq (143) -> ohdnhx, uhnqr, zdglrh, ripilxo, gfszte
huzokb (298) -> mnqii, mieqti
ohuvsf (83)
wcdibhx (196) -> xvwvc, ncmad, jkgnvbn
fxlbc (184) -> mdqeh, kmvcmg, sonvcww, pcckqq
lnknp (91)
swugafb (504) -> ryazls, vmkeu, fewrzd
pmadd (97)
mprgtb (42)
lorxjw (62)
welidg (97)
zzbad (30) -> npccgnv, yqnjd
dwejsn (40)
fvivo (225) -> worqh, yjzqr
zuawuo (111) -> jktlfu, uhvtpfy, ivlus
ikaol (26)
mmhtyd (220) -> yekmflj, nmikggy, xepgx
hujjten (37)
htqps (36)
dlobfkw (44)
fxrijc (57)
xgfad (33) -> zivlnu, ipsst
pafiy (17) -> dhtxpbb, dgcecu
cblhmk (1108) -> ggmhxx, tysdkgl, rrvbwb
kioga (93)
ljhlxc (83)
qsvbb (56)
uaffk (61)
lvptmrf (58)
hebhue (11)
eefyyr (10)
wyylpt (184) -> oneoorw, cfbaj
vmboh (90)
ghcgz (195) -> tajfmq, yzufk
jjhrmi (190) -> qhubjd, uycop
teduvv (25)
xjadrfg (28)
ugcccv (67) -> wehdeq, gyepcnc
psdzpg (38)
hyhbu (593) -> sblfh, ekvdv, iicpkf, xidtz
satjdgz (60)
cjbdxts (34)
gdunxee (53)
fqswta (47)
iwouvid (81)
iqbdxb (67)
ozbjpiq (16)
ysafyj (97)
lcchgb (82)
wkamonm (19)
waqca (61)
bbeyl (9)
rkfspx (17)
nggtuh (64)
jmypc (20)
yfegso (122) -> yhsmjfq, jzmacb, autjn, werkz
zirysk (72)
rtsbgwx (251) -> cbmqx, hvmlb, rsstvn, jtyurkp, gmkvgf, qkawtfu, ggwtf
yxgwsj (14)
xmgqmv (84)
lncmhi (48)
orclyi (30)
bjwny (94)
zehkwy (69)
mzajj (92) -> nljmcv, waiwj
ffsehyc (17)
agelbfq (343) -> iuchai, qynrx
dgcecu (86)
wtqxei (61) -> afywb, dqbfloz
vlmihf (32)
lovox (77)
cmvofka (30)
ttbuzrh (96)
vsunxw (196) -> pdbykx, dnynny, pqjua, jhnujj
skfnp (97)
upuybrd (300) -> dnrjb, rfknc, bbeyl
cpmebw (60)
wkmtw (59)
rpvwtq (5)
jenfafh (58)
pubtxq (51)
xlkwyg (55)
iltoh (22)
ctaazgn (103) -> hywzja, pywmbis
zxhqlfy (26)
dklujy (76)
khgvmj (66)
yfnkp (33)
edsjbi (37)
brtomr (75)
siqcu (15)
kxdehcg (13)
vmkeu (315)
momda (90)
pocvrcs (6)
sonvcww (17)
nemrt (91)
ldbkyg (75)
jsrrt (22)
ifuvyo (180) -> zvszwl, utewfcr, dtmbf
kfzqw (80)
iyfyi (41)
tykwy (44)
twgjdmg (24)
qface (27)
ygkdmh (74)
sblfh (120) -> gglxj, fqswta
gbldz (49) -> xitcp, jpynea
hmjpa (122) -> elovaun, uijgiu, apxgf, nlacdac
wsixz (14)
vgegr (83)
fggyk (46)
kjoru (16)
ixqrl (22)
gklehu (84) -> sazbmjz, piexct
xxego (33)
jxfimbl (95) -> nvpdisw, kioga
vymmkdf (116) -> ofqbu, sboms, obbpd, czafdho
jpwtbds (1608) -> zwutlym, qntzr
xsztla (828) -> cmdizw, qxkhq, nfcbi, rtutzu
wtfliw (87)
lbxrh (94)
ybioco (29)
yvdhwyh (102) -> xpewzk, hdxrbzc, vsaejz, pudso
eauxeyl (53)
skuazsw (70)
jlcie (99)
ckmftuc (21) -> khixdho, ihzsljz, uvkxner
yuikqm (68)
dqbfloz (87)
zofjia (133) -> gshsx, ntkpthi
vyvrn (173) -> lrjbgd, vwojto
tszockk (729) -> ctaazgn, gqbwc, wcdibhx, cujimpt
ydqqgrw (15)
hcxwql (398) -> lpoejf, cmvofka
gjedup (5)
arelp (195)
aonfn (235) -> kzkfcn, eefyyr
lsgbe (99)
gunvu (99)
kasaf (34)
imohij (13)
khwbzl (1131) -> zlbnkdc, ljmrml, roqfxg
nwikfyc (80)
khtegw (91)
epggt (90)
yapaib (175) -> gunvu, ymdmn
saawhdk (12641) -> vwvowk, ilcsp, vatflrk, iajts
qoetrb (15)
ztmmr (147) -> ypkhqlq, uitfx
uqfbnlo (69)
sgrhs (249) -> zymggc, wnvrg
hqjinj (101) -> skuazsw, ewwfzg
vmpnccn (73) -> bidhw, qriyeb, xsyzhcf, ehjjbu
vqddcl (71)
yffeit (76)
xvzinl (99)
znzbkh (16) -> swnan, tbioyr
gnjit (23) -> dhfagjw, xxnpoe
qojhhod (1789) -> sjdanf, hmjpa, szglq
aluqao (313) -> lyhlx, ouhuptm
ipysrdj (222)
worqh (73)
tsxfibs (46) -> yfnkp, edjlm, txbgfm
pcumn (420) -> qwcyozf, dskuj, anoxh, dkmkdfd, fkapr
mejwrm (139) -> oxsewk, zsknxq
aynpyne (44)
sikmtaj (58)
sbfprua (70)
wwofru (53)
nmuxe (88)
uuvtlk (74)
rqisvrh (2703) -> bvmgt, gbxxpd, ffinat, ympbbx, uimoc, shesfq
ehjjbu (89)
cbmqx (163) -> bnlbs, psdzpg
naekrk (70)
cvnrr (17)
pwnqyt (133) -> zijzutq, yvdhwyh, vbmyyrh
sagyrje (49)
efuysje (97)
pzwtjfj (74) -> oyienb, ozbjpiq
ggmhxx (42) -> fhhgts, cepxc, zwzxy
bhfui (13)
chlpx (87)
hmlbrz (55)
oneoorw (90)
kyfuyaf (79)
kiylza (88)
fghxbc (99) -> fozagvz, wqgssb, kqqsq, oijwjli
qgxgzo (14)
cubqfzc (184) -> qwmqci, dmvcduz
lcqfe (61)
xypffi (11)
qntzr (92)
mkjuq (181) -> jdiczst, edsjbi
dhtii (62) -> kfzqw, lbozpy
amtqhf (99)
ixknk (37)
iuapj (162) -> gzfrn, wqtuhe, fndyvvn, zjveu, iebulx, agelbfq
khtooum (53)
aecsfp (72)
fcdcdh (88)
junfev (18)
pxfrz (91)
xratfed (6)
gwbfat (26)
cvcblhv (73) -> jbnns, glkjrrs
sdfvrod (114) -> lcqfe, uigcn
xkfkucf (951) -> skbrota, pwvahdb, odpqjr
okkvefs (820) -> fpuscxk, zhdioii, gzxnn, koxnez
dgosy (59)
yhvndwy (27)
pefzsea (86)
xaogy (131) -> ixknk, ykvss, hujjten
nvpdisw (93)
lmkwafp (56)
cwnvk (51) -> tvdsktm, pwzsq, plhlj, ayqbj
phbtrm (171) -> hmmjjct, xzvln
mrmbyj (53)
jibemf (87)
tysdkgl (20) -> mrwbv, llkaoeh
fpuscxk (147) -> ypdumo, lvdrrk
ejkumeu (235) -> xypffi, nvcafwu, cvdows
uijgiu (38)
cjjynt (264) -> rkwhbhr, axjvvur
nobfn (236)
svanha (62)
nuxxmd (53) -> lybaepp, eolqn
vsaejz (45)
hbbpuc (238) -> thrvlt, ziiqv
tbley (31) -> nvfca, nojly, nguafeb
bkkwe (70)
tywzxwb (24) -> lbhlxqa, dklujy, vzxktth
ezqeusd (71)
qwcyozf (115) -> igzvp, vtefqb
xpwxo (80)
layqazp (39)
hwdtvvc (40)
pwnxw (69)
jobwpao (181) -> pqgiox, uloppmh
wrhnq (87)
amsfvm (53) -> nqgbp, bcldmsg
dfxjjzr (190) -> udaitd, sdktm
cnwzxpy (65)
kpvbt (85)
ifbhg (62)
cpeonw (27)
rsizei (20)
gmkvgf (63) -> tykwy, dlobfkw, aynpyne, vaovit
bjiuus (56)
bwpeux (17)
szrkuzi (27)
ygvpk (33701) -> saawhdk, svthizp, abamn
mjtji (35)
rqvvv (50) -> pzbxpou, rxzfdg
pozua (128) -> vljjqbw, hmlbrz
hmjueiq (79)
hdxrbzc (45)
twway (181) -> orclyi, hmdxion
jocmdmv (72)
lacddy (68)
lsxjl (94)
edotax (14)
gmirjhi (62)
iwicpur (10)
uigcn (61)
ynhvfvx (32)
ugavy (91)
jbgxcj (48)
zdglrh (239) -> csrww, haqaohl, gskveo, qoetrb
lmlsog (62)
sazbmjz (65)
ymeoz (24) -> lbxrh, lsxjl
hhqmsd (34)
ykmfoah (245)
lfdefc (30)
qynrx (53)
znely (919) -> qcmnpm, yjutt, yqgesx
cauig (58)
gvamhux (71)
hqqingt (13)
fiynt (72)
tyysd (63) -> cjjynt, lzeud, wyylpt, pewxc, ibevwow, fvmeeas, uksnrfx
igkrktn (37)
pzbxpou (87)
dllzp (59)
iblvki (11)
vaovit (44)
tcpduh (212)
btpvxq (56) -> urktg, ifnkl, hbbpuc, casmwo, ylqvuk, dblmcye, zvpboy
xxnpoe (67)
sboms (24)
whvvemg (83) -> tafss, vnfigul
ljjyy (64)
qvdid (70)
koxnez (71) -> bolpsk, pefzsea
elgtk (40)
wesoooi (87) -> pmadd, welidg
tiikt (92)
eadvs (797) -> ofnewz, neywe, qklqozd, ykmfoah
sreke (34)
clqqyi (51)
kuufl (1074) -> aonfn, cgrima, lhfuku
qswoy (7) -> bklfmch, xpwxo, eoustfr
rakfg (91) -> fiynt, opdtk, qkhvu
zvgsa (59)
gskveo (15)
clbbi (27)
ilcsp (844) -> pafiy, phbtrm, nwupf
blnwcb (17)
udaitd (23)
aewmad (73)
tvdsktm (64)
zavcu (25)
gglxj (47)
jmrlaxf (48)
sppxnti (48)
zhdioii (243)
olepfo (98)
ezsnmw (14)
hsmjm (25)
xmuxsr (44) -> bjiuus, qqjly
kmvcmg (17)
zuoeh (7782) -> hbaxtai, pmefov, zfteizz
sqxrad (80) -> marord, jbgxcj, xsmyok
vrbcn (34)
ibevwow (308) -> cvnabd, pbckxv, xrunic, ezsnmw
rqilp (25) -> quwfos, vekxdqh
ojfzokk (99)
bjwvw (209)
sygjhzp (36) -> hsxhyf, knqxdq
pjvnmqn (43) -> azoutv, jwhcmc
qqjly (56)
iezyfwf (20)
wrlkfij (55)
wuvhyc (40)
aqgtml (51) -> wywxu, tiikt, uwnwp
fhjysp (164) -> czvyrzi, nbmnwsq
rmlru (71)
bdiiv (15)
tlxekcp (42)
lbozpy (80)
uksnrfx (224) -> bkkwe, sbfprua
gmuwpyi (90)
zsqzm (64)
evhhfo (5)
xdyrvy (189) -> wyois, cwkdlil
gbxxpd (82) -> rynmge, hngao, vlqyxe, jhyjqxq
nzhqepw (60)
zfteizz (59) -> ytvjxq, vhoasjq, fwwub, xglsp, cubqfzc, nfucnzx
ulragq (39)
jgrsa (269) -> ukfsn, kptjhtd
uisnk (2228) -> tbley, eqkot, tlmfw, gnjit
chyhykz (59)
zjveu (437) -> qhyfphs, bfwnv
syliku (78)
syzcti (32)
nnmayb (85)
zdqmuey (209) -> ibkfqok, lhmgw
myopc (16)
cifdyio (74)
nguafeb (42)
dbczwnr (15)
vxede (10)
ouhuptm (52)
sdyox (93)
slahk (43)
skbrota (217) -> toeyz, gjcibb
hbaxtai (851) -> zynpp, ylbaxtu, rfwaq
hvdfq (112) -> imohij, pwetqid
zgfqdv (15)
dpqxfp (209)
arskvgv (88)
bqywl (157) -> ooufod, clqqyi
ymataqq (22)
krwgy (109) -> dllzp, xqpfvwx
ohsyhln (53)
ofqbu (24)
ccpnopa (59)
bfkbp (156)
bolpsk (86)
tckyc (456) -> dzfclsm, sqxrad, qkrpzl, ppcsoo, rqvvv
qbftkij (204) -> rtcfcyn, vlmihf
bpcnzi (82)
rhacrz (27)
wzbqh (306) -> xratfed, fjcobs, enlctw, pklcmix
qqnmzb (1723) -> mzyqoc, soirl, dhtii, ahbcl
tuvehcz (17)
yzufk (30)
xsmyok (48)
tgiou (19)
izvtqsa (84)
ooufod (51)
rfwaq (80) -> nmuxe, ttofoep
lpoejf (30)
oykwsk (76)
wdipy (92)
jbnns (93)
qcxiehu (312) -> eeune, gbldz, ztmmr
vsslzfp (91)
uimoc (30) -> crhojk, ejkumeu, lovaf, fhjysp, uxbrs, qbftkij
phtghp (3945) -> rpjozji, swnafht, swugafb, guyrnpn, evbtz, hyhbu
svthizp (1149) -> saddwx, olhnx, uisnk, iuapj, btpvxq, iovxjv
xvwvc (23)
ovpzt (139) -> dfywz, emtjcx
uatlbrq (17)
hmpisyb (41) -> igdtz, lnmhw, ttpmzgm, dkxzsaq
pehflc (56)
iedfk (49) -> ydqqgrw, bdiiv
nomeb (112) -> mmfuve, lxudoaz
ffuqr (90)
gsgwqk (204) -> ddraicf, dgyulo
igqle (222)
jhcwkl (41)
yfusbw (76)
lpsafeq (51)
lklqxg (83)
lofayaa (22)
itqwz (113) -> rhacrz, keusrg
xbidr (74) -> pozua, gisiv, skpux, tcmdaji, gorpw, yfegso, waakcx
pnouux (9)
ryazls (221) -> zhpfgzv, rvpxob
bxwng (53)
xwkyrer (8691) -> srnnjbb, qcxiehu, gqhnstx, ghdbwu
nbmnwsq (52)
cxfsoh (53)
gdylf (74) -> jlcie, hewatw, sdpsl
vksyy (96) -> wfpzhfz, phsmt, zuwaw
qekxzsx (87)
qzglav (42) -> ubxvdq, aqvtgi
xsoqzbe (1068) -> llgbz, itqwz, yxzlpnj
lndczw (19)
perzy (46)
oigsk (38)
uytsra (106) -> hkgxpgh, gzxddd
zszzkl (72) -> ifyja, cdqdm, rwmdbn, exwzzr, leyikdx
wfvjnxf (93)
pklcmix (6)
cvpuwrb (82)
ileugiu (225)
defbun (57)
fbzvm (72) -> vgexqw, cejtpyf
aduikk (133) -> kmfel, paopwt, hdjzg, qckzqv
shlfz (3932) -> swcvn, obwkzhc, pcumn
yhjhgu (57)
vgiqvsi (53)
iajts (451) -> izzzyqd, fegaac, jagdwg, mblvpm
kxwbdvm (1104) -> mzajj, ubuge, ddguar, znzbkh
rynmge (25) -> ecwjaw, zdqsmv, aodoc, pxfrz
bqxnoid (31) -> aqgtml, qprenhy, upuybrd, sgrhs, flptbw, mxwbp, boszym
kqqsq (37)
xrunic (14)
vqnyvr (57)
lvdrrk (48)
bamxvq (86) -> zywvdda, ygnkwn, taxrkif
xkzvo (33)
vhoasjq (226) -> uogva, tuvehcz
hkgxpgh (46)
zocwx (35)
qhyfphs (6)
coselm (44)
ypbrxyq (206) -> siqcu, kqicqf
ffgzg (151)
ujuunj (64)
iuchai (53)
ykvss (37)
ovszp (64)
helyfoo (65)
pryhgj (81)
fxhqq (29)
eeshl (30)
qzftgbx (44)
ppcsoo (26) -> gwqgewp, lsgbe
xinfpy (53)
ddraicf (9)
xidtz (126) -> azuoza, coselm
ipsst (23)
wzvzgg (60)
fqqyipa (200) -> eeshl, cxqeyt, qkhqrq
jpyvpw (20)
xhzyzer (82) -> pawvr, dckbvlg
boszym (129) -> rqrhrnz, beewze, evqibrc
kabqu (38)
sdpsl (99)
bekguie (31)
klovr (30) -> kihqh, wafjqj
zklbfdg (47)
ccter (84)
wzqanwj (240) -> zavcu, hsmjm
uxbrs (94) -> qekxzsx, odqns
dzxpqj (22)
csrww (15)
wwxak (108) -> vbmqj, ugavy
etfbuu (22)
miwst (40)
iiugq (15)
cuprzhk (40)
waakcx (238)
faijmsh (35) -> rwakmo, nwikfyc
cvlod (76)
sjgvkg (1566) -> cldaag, bjwvw, dpqxfp, dgdtt, ujbzq
ixxww (61)
mipqe (91)
xitcp (88)
lxudoaz (51)
ibkfqok (19)
ulchkal (55)
qubli (60)
tsamaj (1171) -> axgndac, vbuvkx, uqeag, qyurm, lzypz
mmpnppi (60)
prlvn (63)
ddwursx (245) -> sdwrx, jtfylv
aljgr (62)
glkjrrs (93)
vwftcva (46)
ylbaxtu (144) -> frcrd, shjxje
jqpdpr (14)
yzhvrx (90) -> viqvtzw, twway, zwzzce, hqjinj, mejwrm, yyursb, gfigt
iqoxkhd (91)
locrtxl (2681) -> xsoqzbe, oxoocfp, ndkcn, vmeubf
fbmajm (58)
rylaxjf (90) -> ojfzokk, iksaub
wyois (46)
ecwjaw (91)
alhlvth (36) -> zirysk, orpjw, zdxscz
jlofqwz (13)
sdktm (23)
bjvuicy (217) -> xjyyfe, rahgf, qqllir
hepkop (7311) -> xkfkucf, xbidr, yvgkdi
gqbwc (25) -> ytxcti, qubli, cpmebw, wzvzgg
yojcz (201) -> rkjuz, rmlru
obwkzhc (86) -> vksnq, tijwlva, szcozjr, krwgy, pnhpv, ydiicdl, kskts
cdqdm (2502) -> wnfqsa, jbqmy, hvdfq
gjcibb (23)
igdtz (83)
phsmt (112) -> jqpdpr, bmnsmqz
hdjzg (77)
jukxlr (29)
oajdx (61)
ktayld (179) -> skfnp, xwjmsjr
dkxzsaq (83)
utewfcr (50)
jljjai (14) -> fhycptc, olepfo, armfpvt
gnughzp (5)
oyienb (16)
kqicqf (15)
ggvwlp (80)
vlbivgc (13370) -> xcxqa, aeatvub, pwmrau, rqisvrh, hepkop, ogmoqb
kczlit (64)
mblvpm (124) -> fbmajm, ofwbsgp
wehdeq (6)
fegaac (206) -> ffsehyc, sapwhr
qpsirr (15)
gisiv (80) -> hmjueiq, unqui
xjkquk (87)
rsdub (61)
gzxddd (46)
oxsewk (51)
ahfdt (234)
wafjqj (80)
mhjeza (93)
bljkg (12) -> yivjj, cxcyrd, lorxjw
fkapr (39) -> wwofru, weyfsg, khtooum, ohsyhln
dtfdn (71)
zxgrq (25)
rlfqf (63)
hvisx (68)
laopkn (40)
zvszwl (50)
gorpw (55) -> jnrnwos, rsdub, uaffk
skmbdhz (54) -> scqtkga, xdojlm
ecaiau (424) -> rakfg, ddwursx, nsbzfgy
bfwnv (6)
uhvtpfy (47)
zafggcz (17)
qkrpzl (170) -> kjonvut, clbbi
bvmgrs (75)
iicpkf (16) -> vhkydm, htecpc
rbuwrpw (17)
funnv (5679) -> cdlzi, fpfpv, bqxnoid
flkkr (74)
brzucfh (39)
lfavcfd (72)
dmvcduz (38)
izdhn (1183) -> uytsra, xxmtvr, bljkg
hrnrjrt (9135) -> kuufl, khwbzl, tocvooe
eiatt (291) -> gfhummb, jsmde
czvyrzi (52)
ypkhqlq (39)
egxzjn (81)
qzzlmw (319) -> szrkuzi, cpeonw
xepgx (64)
iftyxdd (79) -> xmaqelf, htqps
rskara (87)
uytsdd (292) -> hyehtm, zdissfg
mqodhde (36)
ylqvuk (48) -> shdgsk, fcdcdh, kiylza, arskvgv
gisrnfs (23)
vntsex (77)
rwmdbn (2136) -> xmuxsr, bfkbp, ibjdru, ttvfha, zhohes
fhhgts (38)
opdtk (72)
beewze (66)
leyikdx (1995) -> ewswf, gaashgh, cwnvk
kcbwrrr (631) -> wzbqh, sysdxvb, huzokb, ifuvyo, ghakp, rqqlzs
jwhcmc (72)
mqcflzv (76)
ofwbsgp (58)
hiyswbt (889) -> ileugiu, suuhqpd, yffhk, htstksc
armfpvt (98)
zsknxq (51)
pewxc (246) -> rmexd, wkmtw
lhmgw (19)
qwmqci (38)
hioofm (319)
cujimpt (137) -> ovszp, zsqzm
htstksc (169) -> wsixz, egszxz, gzjut, rutqzk
quwfos (85)
tcjqw (81)
orbcuzi (89)
sybpg (49) -> sdyox, dwrwuoq
qyhvc (16)
sadnqcp (62)
zihpcn (232) -> jukxlr, louebj
zxygs (208) -> njvkdrp, hqqingt
gyoqtcg (77)
emwblax (49)
hewatw (99)
qxkvfid (53)
kglsx (74)
yhfpq (56) -> cxyfam, mjumixz
zivlnu (23)
xsyzhcf (89)
howlyws (206) -> gwyljq, xhhwwso
uycop (59)
yhxlzc (91)
isqvoex (30)
bklfmch (80)
tvrxaw (106) -> qdqtw, qpsirr, dbczwnr
lkreb (72)
kxyfb (90)
jnrnwos (61)
mxbrva (72)
qkhqrq (30)
gfhummb (40)
zwzzce (221) -> ahqfu, gjedup, evhhfo, rpvwtq
rrvbwb (34) -> wcmyn, haclvfu
enlctw (6)
yeaic (61)
otipr (480) -> gdrxgji, fonrd, wqoae
qxkhq (143) -> ixqrl, jsrrt
wbqeo (22)
iugsida (64)
azuoza (44)
yxemuyq (19)
fyouz (18)
bnlbs (38)
hilafgl (59) -> hmpisyb, ktayld, yapaib, bmdgthp, qzzlmw
shdgsk (88)
rnqgy (34)
kmwxj (92)
hmmjjct (9)
mefmo (46)
lwvfsu (53)
fixwkec (84)
haclvfu (61)
werkz (29)
iovxjv (1204) -> uhwnr, ypbrxyq, dfxjjzr, pxkypf, nobfn, tkdvenx, sdfvrod
dmglcj (17)
qprenhy (221) -> cxfsoh, mrmbyj
qmwmbsk (804) -> tmoui, amtayi, wgqpt, xaycmtu, kztkif
zywvdda (52)
ntkpthi (6)
jkkqxfr (1135) -> nomeb, fbzvm, gklehu
muptknj (66)
uwnwp (92)
ggwtf (213) -> vkaay, kxdehcg
afywb (87)
xglsp (94) -> ljhlxc, htpblzv
elovaun (38)
qhubjd (59)
exwzzr (1542) -> bchixdc, fphmu, hcxwql
xhhwwso (43)
uevxbyn (170) -> ucaee, yuikqm
pqgiox (50)
edjlm (33)
ypdumo (48)
ehhbjt (26)
cxyfam (98)
bhqlq (82)
abamn (8) -> tsamaj, qojhhod, kcbwrrr, ttfyrk, qqnmzb, tyysd, sjgvkg
sjdanf (49) -> ldbkyg, brtomr, qwfvm
wcjnjpf (57)
xzvln (9)
citaywz (64)
aqtog (66)
khdbe (9)
vksnq (85) -> vqddcl, ezqeusd
fkwbo (91)
jefjzvl (73)
azoutv (72)
aqvtgi (90)
vlyof (97)
gwyljq (43)
xmedt (39)
rsstvn (75) -> bpcnzi, cvpuwrb
vekxdqh (85)
toeyz (23)
pvyvx (99)
pwmrau (9594) -> roogi, ajcbzv, pwnqyt
qahzrif (63)
gzjut (14)
mzyqoc (194) -> yxgwsj, fwabsk
tkdvenx (44) -> sppxnti, lncmhi, jmrlaxf, qmati
vtefqb (68)
yekmflj (64)
pdbykx (14)
fpgyyu (67)
qjbbyb (26)
izzzyqd (186) -> djvfa, qrrvi, junfev
lsire (61685) -> locrtxl, shlfz, ycpcv
vbuvkx (204) -> tlxekcp, pxdkes
ahqfu (5)
cjxyp (81)
aeatvub (10983) -> hghjsk, vksyy, otipr
jhnujj (14)
cxpwfir (63) -> mhpzrw, txwzysl
gcydgf (22)
zlbnkdc (92) -> lfavcfd, lkreb
lrjbgd (41)
casmwo (246) -> nsbnixe, vntsex
rqqlzs (270) -> lfdefc, isqvoex
xtqthxs (44)
kjonvut (27)
mptovq (19)
dwrwuoq (93)
ziiqv (81)
vnfigul (38)
jpynea (88)
rplcrt (90)
flptbw (159) -> xmgqmv, ciprksz
nojly (42)
jbqmy (86) -> zxhqlfy, ehhbjt
ozhydny (40)
zzflc (92) -> rnyndr, eiatt, fvivo, gdylf
jktlfu (47)
njvkdrp (13)
qyurm (76) -> eauxeyl, nrwmjk, qxkvfid, rjmuly
bjyraf (7)
zhpfgzv (47)
qfcetm (30) -> iqoxkhd, gptyqwd
dhfagjw (67)
qriyeb (89)
ucaee (68)
djvkd (36)
scqtkga (54)
yvgkdi (992) -> pjvnmqn, kgoyufq, zivjpfo, amsfvm
zsukqjo (90)
hfmaqp (94)
gxsxqwt (20)
marord (48)
uloppmh (50)
iktmpdq (34)
wnvrg (39)
cxiturs (95) -> ttoer, jpwtbds, yykkph, yffpvf, ahjlf, yoxetv, okkvefs
fewrzd (24) -> efuysje, olrgu, rtmiw
swnan (85)
xdojlm (54)
dhtxpbb (86)
roogi (100) -> cesnj, wsvfkr, hzhcl
yffhk (143) -> jfcoc, vpltn
ffinat (630) -> avyoy, tywzxwb, zuawuo, vsunxw
txrfl (81)
eoustfr (80)
bxmcg (249) -> epggt, gfjsie
kdeqm (99) -> qjbbyb, ikaol
lfsvtih (97) -> aylxc, bekguie
qkhvu (72)
zzfcq (7259) -> balknnd, iiqzvha, kzzfvt, ecaiau
kebhn (106) -> iktmpdq, sreke, cjbdxts, ehlnex
ljmrml (178) -> fxhqq, ybioco
asozcan (96)
ceeotg (53)
fonrd (12)
fvmeeas (88) -> wdipy, khnjt, kmwxj
cejtpyf (71)
wsvfkr (193) -> liznr, yytpewc
evdwf (31)
wqgssb (37)
uhnqr (247) -> oncexf, jeiqx
xzmdis (24) -> yhjhgu, vqnyvr, taacpu
tafhilv (11)
mhpzrw (96)
cgrima (79) -> xvayjwv, eyxccr, xtqthxs, qzftgbx
nrwmjk (53)
yjutt (47) -> jocmdmv, iaoyb, aecsfp, mxbrva
cxcyrd (62)
fwwub (146) -> defbun, wcjnjpf
sapwhr (17)
ihzsljz (46)
zmkwnv (66)
yytpewc (50)
xdctkbj (83) -> zuoeh, tnqram, funnv, zzfcq, xwkyrer, cxiturs, phtghp
kptjhtd (86)
pcecbrn (66)
sdwrx (31)
dfiyju (49)
gxddhu (133) -> itlwpm, bdnjn
zvpboy (76) -> txrfl, egxzjn, iwouvid, cjxyp
fndyvvn (85) -> khtegw, aocfuj, mipqe, lnknp
ozvtqp (53)
kxizh (74) -> yojcz, uafhv, wnpnfiv, kivyltn, jxaorvd
zwzxy (38)
rkjuz (71)
jagdwg (46) -> ytiljvt, smascq
rutqzk (14)
zymggc (39)
afbzsz (148) -> vzcklke, ggvwlp
ymdmn (99)
twoyl (58)
lqcutyt (74)
nlacdac (38)
otikjx (40)
rxzfdg (87)
huvihu (49)
cfbaj (90)
lqlyf (59)
apxgf (38)
nqicerc (62)
iksaub (99)
avyoy (252)
kzzfvt (94) -> aluqao, oherzyz, dwnokzu
uqeag (162) -> prlvn, xtaoisd
crhojk (40) -> yffeit, yfusbw, oykwsk
oxoocfp (237) -> igqle, eukgf, qzglav, ipysrdj, gsgwqk, kevlq
aylxc (31)
khnjt (92)
ytvjxq (260)
xkxqc (64)
ogmoqb (8) -> uqmgmst, hiyswbt, qmwmbsk, skmuo, tszockk, kxizh, thbwh
nvfca (42)
xaycmtu (67) -> cnwzxpy, helyfoo
kklbcs (74)
wqtuhe (341) -> myookpi, gqikhhw
unqui (79)
vhkydm (99)
zcomxf (40)
hsxhyf (63)
rwakmo (80)
uogva (17)
cesnj (57) -> hrokzl, rtgobsq, kmfsmp, chyhykz
rtcfcyn (32)
qckzqv (77)
oixlcn (37)
iaoyb (72)
idrror (34)
bcldmsg (67)
lbxdtms (281)
adbxp (35)
qsjqlp (74)
mjumixz (98)
rtmiw (97)
jzmacb (29)
umgch (64)
rpjozji (279) -> faijmsh, xzmdis, arelp, guvke, rqilp, eqpuuzs
xvayjwv (44)
vgemekb (53)
odpqjr (263)
hekibe (63)
xmaqelf (36)
ivlus (47)
rkwhbhr (50)
pawvr (12)
crcrimv (57)
ukfsn (86)
nfcbi (117) -> zocwx, mjtji
qwfvm (75)
jfieeor (96)
eolqn (91)
bgehlas (6)
ruozk (10)
gqikhhw (54)
pqjua (14)
jtyurkp (239)
wjbdxln (99)
paopwt (77)
fefuzon (126) -> jenfafh, cauig
ifualyn (93)
npccgnv (50)
nvcafwu (11)
htecpc (99)
uxbhu (175) -> bxwng, ozvtqp
gzfrn (365) -> mprgtb, qkicc
qlwhsix (71) -> bjwny, ghapm
uvkxner (46)
kmfel (77)
ytiljvt (97)
cxqeyt (30)
yyursb (93) -> lqcutyt, uuvtlk
mpijr (88)
rpqbv (23)
oginzo (24)
sydjg (10)
ehlnex (34)
ukqmhyc (25)
gshsx (6)
nafrmeo (76)
ifwmfdm (114) -> jibemf, wtfliw
rmexd (59)
ujbzq (41) -> izvtqsa, ssnhc
scxdo (56)
bvmgt (1203) -> xqncgyu, tsxfibs, zofjia
vkaay (13)
pxdkes (42)
witry (76)
ttpmzgm (83)
pxgkg (69)
vwojto (41)
jcise (35)
tbioyr (85)
wnpnfiv (55) -> tehat, ttbuzrh, jfieeor
ejxib (53)
htpblzv (83)
dgdtt (155) -> qface, yhvndwy
weyfsg (53)
aodoc (91)
vmeubf (759) -> sygjhzp, ilhib, ldgyqh, uewdyd, skmbdhz
pwetqid (13)
pudso (45)
ibjdru (136) -> dzqqgbm, qivxs
rtgobsq (59)
kqiuy (81) -> ffuqr, rplcrt, gmuwpyi, zsukqjo
gfszte (23) -> pxgkg, zehkwy, pwnxw, uqfbnlo
ngxtfhu (25)
fphmu (62) -> jpvxzcn, xvzinl, pvyvx, lxgvhy
yxzlpnj (85) -> iyfyi, jhcwkl
khixdho (46)
pjjmau (353) -> hktzoq, oigsk
ttofoep (88)
fhycptc (98)
nsghrq (105) -> bvmgrs, bsfygp
hmdxion (30)
nsbzfgy (167) -> mplhwo, qvdid
hngao (361) -> olhfbr, qgxgzo
iitbuxz (1186) -> eexmf, emuwzd, zzbad
ywnsmem (246) -> qjuuu, ohuvsf
qjsvs (66)
uuyfecv (9)
uafhv (223) -> azmneyd, mmpnppi
aocfuj (91)
kaghlc (34)
eionkb (1079) -> hxmcaoy, sybpg, jfhqrla
hzhcl (127) -> vgegr, lklqxg
ssnhc (84)
ttfyrk (2158) -> xnxsdq, ffgzg, tvrxaw
nvfqmkw (96)
qrrvi (18)
ajcbzv (55) -> jjhrmi, jljjai, afbzsz
ydiicdl (93) -> iqbdxb, fpgyyu
eyxccr (44)
gdkjoit (56)
urktg (196) -> pxgcbfi, lacddy, hvisx
wuclmu (64)
rosfnb (26)
osjsm (87)
kgoyufq (133) -> holen, gjctf
kihqh (80)
xjyyfe (25)
gyfbgkr (16) -> gyoqtcg, lovox, srzfd
bidhw (89)
wfpzhfz (78) -> zyfwjxs, evdwf
rnyndr (149) -> kklbcs, ygkdmh, cifdyio
xqncgyu (25) -> nzhqepw, satjdgz
hvmlb (141) -> qwxwd, huvihu
txwzysl (96)
suuhqpd (48) -> ccpnopa, lqlyf, fxpoal
djviima (31) -> qyhvc, kjoru, myopc
ddguar (116) -> adbxp, jcise
wptyd (87)
obbpd (24)
anoxh (63) -> hfmaqp, ggfmiv
llgbz (167)
mhxheb (167) -> rkfspx, uatlbrq, cvnrr, bwpeux
yybnbso (89)
lxgvhy (99)
yffpvf (1698) -> pwoyfeh, zklbfdg
ttvfha (156)
tocvooe (99) -> fqqyipa, zihpcn, wzqanwj, wajnseu, bnevesk, wwxak
taxrkif (52)
rvixnmq (376) -> fyouz, nsnqedk
uhwnr (60) -> zjzgs, mpijr
djvfa (18)
rjmuly (53)
pnhpv (227)
sjaax (190)
amtayi (29) -> qsvbb, scxdo, inlrm
vbmyyrh (142) -> uwjowb, naekrk
gomcbqb (203) -> lofayaa, iltoh
oijwjli (37)
wajnseu (20) -> kxyfb, vmboh, zguzlx
hghjsk (348) -> fixwkec, gcowt
dzqqgbm (10)
guvke (19) -> brjgwq, kejtzg
jpvxzcn (99)
mplhwo (70)
dblmcye (325) -> bffnszc, zxgrq, ngxtfhu
ahbcl (178) -> hebhue, edlved, tafhilv, iblvki
liznr (50)
pwoyfeh (47)
jdiczst (37)
ejvipa (38) -> kpayh, uzvsml
oherzyz (53) -> yhxlzc, fkwbo, ziyyc, dlfmj
kivyltn (303) -> vxede, pjazwiy, ruozk, sydjg
szcmb (176) -> bjyraf, bvypab
ofxzyhr (22)
xmzzrgs (266) -> aewmad, jefjzvl
gdrxgji (12)
ziyyc (91)
wgqpt (29) -> evcveie, ccter
yykkph (63) -> gyfbgkr, fghxbc, qswoy, gomcbqb, tubhp, zdqmuey, gxddhu
yoxetv (1724) -> eeziziu, kaghlc
xqpfvwx (59)
fxaglf (49)
shjxje (56)
cdlzi (1615) -> wtqxei, mhxheb, nuxxmd
zytau (43)
ghakp (232) -> sagyrje, fxaglf
lbhlxqa (76)
bchixdc (431) -> khdbe, uuyfecv, pnouux
olhnx (1796) -> vymmkdf, qfcetm, atbiby, tcpduh, ymeoz
bvypab (7)
hregcx (66)
aucjw (62)
bmqhvfv (40)
fpfpv (1564) -> fxlbc, alhlvth, yhfpq
lzypz (220) -> rnqgy, csyiik
ujjoydl (38)
rfcbs (197) -> oajdx, yeaic
cmdizw (31) -> ydzibri, syliku
iiqzvha (1325) -> hnedp, iwicpur
zdqsmv (91)
neywe (59) -> lmlsog, svanha, sadnqcp
teyakvf (89)
inlrm (56)
kpayh (34)
spwqxpy (79)
ofnewz (83) -> pryhgj, tcjqw
knqxdq (63)
jtfylv (31)
jhyjqxq (363) -> jlofqwz, bhfui
kmfsmp (59)
kskts (115) -> gdkjoit, lmkwafp
hktzoq (38)
tajfmq (30)
zdxscz (72)
pywmbis (81)
yhsmjfq (29)
kzkfcn (10)
mieqti (16)
mxwbp (235) -> fggyk, mefmo
thrvlt (81)
wqoae (12)
yivjj (62)
aumrixf (40) -> ifualyn, kgqzrt, mhjeza, wfvjnxf
gfigt (211) -> iiugq, zgfqdv
cepxc (38)
vzxktth (76)
locto (240) -> oginzo, twgjdmg
vopqzha (10) -> kglsx, qsjqlp, flkkr, fbpbs
lxwvf (72) -> ixxww, mxnlv, waqca
zuwaw (84) -> tbaads, xjadrfg
oothjv (71)
tubhp (141) -> uftnfv, vgemekb
wywxu (92)
uwjowb (70)
pwzsq (64)
eexmf (130)
ldgyqh (30) -> mriqcjy, khgvmj
ewswf (307)
tbaads (28)
rxsihsa (91)
dtmbf (50)
tzhwvzt (89)
qivxs (10)
nfucnzx (68) -> nvfqmkw, asozcan
znwmvr (63) -> ymataqq, etfbuu, wbqeo, gcydgf
kejtzg (88)
eukgf (112) -> rdvciwk, ulchkal
skpux (146) -> vwftcva, perzy
uewdyd (152) -> uamqx, gnughzp
dnynny (14)
guyrnpn (413) -> bqywl, cvcblhv, ovpzt, qlwhsix
lnmhw (83)
llkaoeh (68)
ydzibri (78)
gaashgh (307)
vbmqj (91)
uqmgmst (1336) -> kdeqm, znwmvr, iftyxdd
tijwlva (187) -> gxsxqwt, yjrfr
fozagvz (37)
tafss (38)
dckbvlg (12)
oncexf (26)
jkkwtd (142) -> jhwrcb, pbkplz, momda
evqibrc (66)
mrwbv (68)
hrokzl (59)
soirl (206) -> uqjfarv, myqre
ubuge (186)
rtutzu (73) -> crcrimv, fxrijc
pmefov (983) -> gibdxij, whvvemg, lfsvtih, ckmftuc
tnqram (7095) -> kxwbdvm, rhcxf, nihiexp
dzfclsm (186) -> yxemuyq, mptovq
pjazwiy (10)
mnqii (16)
uqjfarv (8)
xnxsdq (76) -> ukqmhyc, teduvv, lmhamlz
lnwcryv (62)
lovaf (94) -> osjsm, wptyd
rhcxf (84) -> jgrsa, egtruqh, kqiuy, aduikk
evcveie (84)
lyhlx (52)
zjzgs (88)
brjgwq (88)
wnfqsa (138)
balknnd (377) -> kebhn, bamxvq, xaogy, fefuzon
ayqbj (64)
zynpp (67) -> qahzrif, rlfqf, hekibe
szglq (194) -> iezyfwf, jmypc, rsizei, jpyvpw
ocppbp (26)
wuknah (36) -> kczlit, nggtuh, umgch, xkxqc
ifnkl (324) -> kabqu, ujjoydl
eqkot (33) -> aljgr, lnwcryv
yjrfr (20)
cvdows (11)
lybaepp (91)
jxaorvd (343)
zkpfzio (145) -> vrbcn, kasaf, hhqmsd, idrror
evbtz (297) -> ifwmfdm, rylaxjf, oylvq, locto
srnnjbb (51) -> zxygs, rkwquj, owxawf, ahfdt
viqvtzw (117) -> gmirjhi, aucjw
nsnqedk (18)
wiapj (55) -> djzjiwd, lsire, vlbivgc, xdctkbj, ygvpk
jhwrcb (90)
zdnypzo (66)
eqpuuzs (149) -> gisrnfs, rpqbv
kevlq (156) -> xkzvo, xxego
fxpoal (59)
dlfmj (91)
pbkplz (90)
qdqtw (15)
qkicc (42)
axgndac (156) -> zdnypzo, sglkjsh
gptyqwd (91)
cwkdlil (46)
tmoui (91) -> ceeotg, ejxib
xxmtvr (154) -> ofxzyhr, dzxpqj
zijzutq (90) -> wuclmu, citaywz, ljjyy
xtaoisd (63)
szcozjr (215) -> bgehlas, pocvrcs
jfhqrla (155) -> miwst, elgtk
nsbnixe (77)
haqaohl (15)
eeune (31) -> ysafyj, vlyof
vgexqw (71)
ghapm (94)
swcvn (1105) -> sjaax, szcmb, klovr
lmhamlz (25)
louebj (29)
fjcobs (6)
holen (27)
qryui (49)
olhfbr (14)
wcmyn (61)
dkmkdfd (173) -> vvkkkpb, ulragq
odqns (87)
xwjmsjr (97)
rqrhrnz (66)
uamqx (5)
rkwquj (92) -> gvamhux, dtfdn
ncmad (23)
lefxyzt (56)
qcmnpm (335)
kgqzrt (93)
ttoer (916) -> howlyws, wuknah, bjvuicy
rahgf (25)
mdqeh (17)
ghdbwu (863) -> ifbhg, nqicerc
thbwh (832) -> rfcbs, hioofm, jspui
gfjsie (90)
mmfuve (51)
vzcklke (80)
bffnszc (25)
saddwx (1569) -> bxmcg, vmpnccn, pjjmau
bmnsmqz (14)
qkawtfu (111) -> ujuunj, iugsida
edlved (11)
pxgcbfi (68)
gekygl (247) -> zafggcz, rbuwrpw
egtruqh (389) -> ocppbp, gwbfat
rvpxob (47)
ympbbx (1243) -> spwqxpy, iedfk, ugcccv, djviima, xgfad
pxkypf (54) -> hblux, nemrt
qqllir (25)
tehat (96)
gibdxij (121) -> ohsvn, wkamonm
itlwpm (57)
rfknc (9)
ekvdv (44) -> kpvbt, nnmayb
gwqgewp (99)
cvnabd (14)
dskuj (165) -> slahk, zytau
yqgesx (175) -> zcomxf, bmqhvfv, hwdtvvc, laopkn
vljjqbw (55)
qmati (48)
afyxhh (87)
ubxvdq (90)
ckegba (32)
sysdxvb (66) -> zmkwnv, pcecbrn, hregcx, muptknj
nihiexp (930) -> vopqzha, uytsdd, uevxbyn
myqre (8)
nwupf (109) -> cuprzhk, ozhydny
tzrqqk (79)
pwvahdb (85) -> yybnbso, tzhwvzt
gcowt (84)
ohsvn (19)
zhohes (46) -> wrlkfij, xlkwyg
ripilxo (299)
vwvowk (1293) -> dgosy, zvgsa
bmlkhaf (53)
kztkif (55) -> mtflvu, oothjv
ycpcv (72) -> izdhn, yzhvrx, eionkb, eadvs, jkkqxfr
zyfwjxs (31)
esphpt (85) -> emwblax, dfiyju, qryui, eydak
jsmde (40)
zguzlx (90)
pcckqq (17)
hxmcaoy (235)
taacpu (57)
ilhib (60) -> pubtxq, lpsafeq
myookpi (54)
olrgu (97)
swnafht (44) -> lbxdtms, jensj, zkpfzio, jobwpao, jxfimbl"
rows:"\n" vs input
t:([]name:`$first each " " vs' rows;weight:value each @[;1] each " " vs' rows;links:?[1=count each ">" vs' rows;count[rows]#enlist[""];{trim last x}each ">" vs' rows])
t:update `$"," vs' links from t
root:t[`name] except (distinct exec raze links from t)
t:update leaf:all each links=\:` from t 


p2
tt:ungroup `name xkey t
tt:update subTreeWeight:0 from tt
f:{ [t;names]
	subW:{sum (x[`name]!x[`subTreeWeight]) y}[t];
	eqW:{j:(x[`name]!x[`subTreeWeight]) y; first [j]=j}[t];
	update subTreeWeight:first[weight]+subW[links],eq:eqW links by name from t where name in names}

p:tt[`links]!tt[`name]
p:p,root!root
levels: p scan exec name from tt where leaf
res:f/[tt;levels]
filt:{[x]r:select name,subTreeWeight,parent:x[`name] from res where name in x[`links];
  $[1=count distinct select subTreeWeight from r;0#r;r]} 
rf:distinct raze filt each select name,links from t where not leaf
rff:(exec name from rf) in/: levels
rp:exec distinct parent from rf where rff first where any each rff
problemName:exec name from rf where parent in rp, 1=(count;name) fby subTreeWeight 
targetWeightDiff:neg exec last deltas subTreeWeight from `x xdesc select count i by subTreeWeight from rf where parent in rp
select weight+targetWeightDiff from t where name in problemName


