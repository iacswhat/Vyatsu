﻿const
  hor = '+----+---------+-----------+';
 
var
  s, t: string; {делимое, частное}
  i, j, c, k: uint64; {делитель, счётчик, остаток от деления, номер делителя}
  q: uint64; {общее количество всех делителей}
  d, p: array[0..100000000] of int64; {массивы делителей и максимальных степеней делителей}
 
begin
  d[0] := 1; {"лишний" нулевой элемент массива для упрощения алгоритма}
  {первое делимое (исходное число):}
  s := '5064564868692131547164082987657784821063194982164349648676679304167910010674894175527932513988821944156053377103221731094774597133844430077271931108926501656680465853666752934439285530611931498049909356281104656695937649333128081008181155269127178397058580993678811903742999767258852712329276234517396530342772914974343245317440313175846150423080285942673013840742514335456992475863806323866601600806796026236966621564448303948384539959790412567005386335498615802542713888389957931499831305815658337646564366743181600648467424329869202515401627359940736593862390860184071983840069387987506011615375449991222702632705668251066477789369020366711377726797975444153515658414392657313135559230939772792626420502689034786269602364092948673774938574381803831878878299682292147368692844719176845861158484900789366134629227517443469648288448261660943724394454704354926856230408500706103822619350289717627045458659159003382634595709611798851546852426284048580268837485298807366792810712873738739221356466236196581726424999162678671470776606419576586770777435267998329759855400338809691976118310608607609484218016664625898530308104108945873659957544422167434109582876599360018114092147425521302617772659561104037309857036553787159434583155452075103020469622684466915234196237715338209082088378820253106906550437850365383502702648719643253331251064163100359407664419781897891013595440628529705237967085581170293615361699314011630861882524738987652678333011997099867291431291269899687664280910918640749710482764110635292775952010570485352281608520724026738482813177852434327311554506935235789251235841362589766678444957501615614279097773617938990971784233252440431549764792359445868647647356372624672756525210047824704561578435480491350066002931791748598572522738530901132393461783733687734047867177074440879274040078703610054962949105413766922479037185004858637068708222913884694433101891992304482071275093966349540211596783843186962529884860802935164000754369926898341760973457167856943756440188898834508415688377747883798613263814297676954184967628720688742386688042098064555637869918751916904743772972202070659288141387200213432423075039223018612979084907519361204580406418877294096435334608392212132667866736523463905637078463768190142021077441462773286466941027443664434513862211773717161528269628583425918029175135116793543615877004511125838895735484265278624525892891717314807938129345878362255576156624786643968983278053003217390559857918711004770295698664399315229959453735621660471477960256851912986467958746952469710833583021903963923692829020665302360732118048425420522033035628602448655792310238991483304477878003023921276518696088846140160776825716350973949898913669023689759079640788045153753995953409089848071277280723899408262615336300754787337862885186669398178128173658192797732285113751107257215878698569705316532109968097952668595040843755274830250593203183516111445608387948071487531533281988021518472889729771213295676643675853869511325734478879421066385097011762105653532286467141468236261393446720011304034034386969531381984942210783783704718406075675673885507594117388895329198861583919530545570635887467587643186177682370435566640538752901643877702744055516806853363378781568304272137443953543525937668126640992097565744520100412207350522112041665333793833049419340252301122694991083731452228708285133678451277580195976301274178913489332685986202405871846162647770105128726821367584277705945003369538637972837536004189772667924434447368102945985251134142367865333885780873326768825547014030718407514510103474008181363474385007038821651059459308425973520503419723448367742410695063871280578296727474121856766109447767828330582749144776416566068578671011494957442362608519845493864535257533045083623041598752014134975710151531189283611180750547083057131376301774294256721241496381295212053250134115804244344135319278411818967917150682143751199239481963399406106687309931590112566549941019164851742758987072874544082274769770018453857303230715833289132719210770348725656581658647746300505236164211146767619975621166067362605720790402260251443730859177851647560845241586729918926331315031155562716801564770556502981193934121702485016109833791914902083792279295433024951666686518929788103838062581512816733047157695821145350080277152803605618900471740311097142618501233162133711810757234908972297135697911437971198134191532381397680700718115658232749392274339782951175265060407499459850253105687578956663438117879215697987105501001274288143753116942362117507117430488377255076624810375816049287025233511621156727660777871228620480570696807548345198616045235725954569019861993879348219989766159380228378012860846092942284477027916332869177159884508674313272802459657969244168430803988446657690325196635275206652495450163155691526934395403849126201106442749998606088470564518973121203525723316863319370268764499948912201719198340575576193936989004470691885915288049268331434597648018594169997055531210995849938314686533377125085721625019562944525272451732885924572999169110709986343834131651136614217850076106318734151060549669659302463075449181602693778615884018602463798340631237846951672317620172158017854981706944798895895710491953763430131052182707525574080285881722168188078559767237281595119809284555235459264713516869392061685658738550457096917547656731376634267910962672139739207660562015826772448798313625107479798649252537053723055369291848497987249991790707634844941023491730433901148700268211099828441327490240609870229360211923074332373634635638142966760608384117188846016299207781541765487612647481131583894143140220126515368143123013316963737223093635744336411178034988168091545911821138238755610757648392383990184984980844524352365867543644412774943080807138807493140114944842932123289819352632592060221245351162231177796166221913749703996623259120903193626025583157365350313611803318444422989249996512453448599390608165133125514083216859177216705733535470004235314388325509020959944033646324776631357563804312661622916382291740236967711977685909978454104591165328499702546295827075270784948027749632900001584267470038285404398903022187585438216678806573849427579856307168619114883292300955555407776363058660723821395115851479849526884160644255994593025083722333520996537166698765309907123563559468816424632194356867047202295975718699384262293225965022684619375001971240780101233298174403641976527142633113614246112440128210579083006956142909559771256723768399467565631619278188363097664805123468832837223521406348367859441802942328861028588744669932317336815524046109064039081107411411485451632512403893992776816489747064850640070102292633474261881935041363810610054489311521335977632750825360631535051572122237785416063589112034005182952395869704287211209258680590023331840049469275392746092438992510219738976299800193931131957228876125184712469312661131661367475517709400931986574952680933520711784663336884758039172766375066053150608478545920787791642062312516216020813264408882454083953598541585236491361893097108306301804867047577947589469664290848617923630291624401010332555897807850911266344076680268496134717301178649814034615976037443262640431755029039952659621028234953559618442130219985583331975531230684393377062269405984984581108000379520461082056978184270239198917256281164330427311985177776443469776604472006421967242402105085615114920422119496422056036539684225564901256896624729402903868603084073883597034974522648408916621066653812236632405437905075735038129705053476123702784869904415014767142979630527892587503758035497384976695755061898094263271997181817524546489053480563399942220837396820816363168031013647557491390632392335174110727179447232791723449189508329838180364404093966478833603714120457584991068679472001799202606151333276646144994958779359104949385441629396886388261271853179745924796291143674497274515155542664664728156615568572900570561498878116669156384637925736150223996228523109082538187437229885447936322406704492577101673196170309777027402069634578541538752929408219114356312703201917116216012638521713687191442634653008305635601662555060419155316484310437572716025895943908697786957598352686839793847297323751289134657587688494261738740793476608533334333443323364459902847640145622330189598635710411184908110399753493067649778391599836352704281876283824003020817826455597481227994671725483511437032867595694947484989788228154206148440436713589709850756467941515391606520718831885634742002325700614537117800649265611805546363443880314140281381051016367663243118327054484735445026739582755491077089508138734155810070349139898336181615901801714420054815370023218621544853445856971864343043977167856368956050322772157300252362014045025405337834614267577868395510353044299508484334353497663440112877046676279860805158971874387573117966858267739677936054251345542220581752247403429711051362953448182069359700575509200153873065812938165680827002208111144582163117315742956012253239861365774304290740210086375789873727564422008062716350469593713653101197833706001771600068046347576384373249410321802893515224241247970899667400165298003957464090190539991075723396760026612822753876476782793587728367623138263750463803613963712173159382888360401531254798951980218571917547562083379940648662960886691630270327968441213238312193191171219305402113507491346950957718816167527580732842412128469221662246151544960284434475733935748048231107212560360471293284489193196259019635750762193980364139254917873190619976807877503457430256103833371268774439976356880020963434465643911608268237111316725027013639537660414997182903705349807684108739054794982270345234835150401780539437345126350734872744045181763074731205110803262013287222584515997437627437403355219322685219797136393343199122908515418257558001683377610565304657977742490821413746460577035393146808768436851758912781605705340518701069141028233535685090654808714795189562199087473193475655126871194437507070655722237963087353397587704509545499273083927448206459024820702958261203846713457621670142954368916360074411313359118294178463370613547018671314851059723785943409645615080175824099342518466084165137975146552085350958463799634166277391824956781479525821671084369713515461138701474052635672685506863279582904983780858539897151377470583659454755020607737039929363397522846393014033769292219976721312910289028961757830138635069928609585457757829522899188250597463000407894032883598923471130131091702836028698949587128193556388239646639314132315110630208120084591719636030606452242963275137258198776643698606849525342744431501341535677024649052915971458351880642427261914866812624707958856140994173585840850071365854710920771478957580658563987117500676250519091601066307353227338346292080837191436120415048517299811833265729355341871742651036319376583456453199618390313249935303592800870270188704929160902090076526899959571051673364052635890806914889907435979340161147079157596405196483022963580278419038704980667628916306853914336696468344591549739891353824348489680134351409495107639666993465383797310120645559817317411223973503641671568000918284173797750794084755292178143601614071970994298020991228327137296740103332318804126993839959358167181508091065934117975865389690276115164557457538243481215829441869785442230990779200251139171899917103106735137646176824251104440046204768672324104375391126171483882850945000047004712263642324300943859212713235741304531511124817931887892211585807939219376140153821102723864577799324490914619637758495546939200680927152244847902259529696006768263805147401370691370170544700455555907890094047383603824892217359987057514226249810815479387262641895953292021587472509205758058285255778831793903613667944785071070715832760862415268967807717399596903762857565416197881222316974406969343564488201139609451729479153893237000319604609486034267178624726631755593283496689817077951504416604617092072052460248591415869818427541070290632433799638985080287388467859538416897666785772338657171626615566878704688192115594731412513891504989140306900992828598530173944885726248669699038327531932835725327558115709999990831997750165574650538107151938283335065551539076664491522409763564794160954486391687075486572465788067011689550055915523891800404558366996625950064076120182897198597410128962512574206798418653581191523462971991991781749027733576718423042624377296194072217927868069538013041';
  i := 2; {начинаем поиск простых делителей с наименьшего простого числа}
  k := 0; {пока что простые делители не найдены, поэтому их количество пока 0}
  while s <> '1' do {делим число на простые делители до тех пор, пока число не станет равным 1}
    begin
      t := ''; {текуще частное пока не найдено}
      c := 0; {остаток от деления пока равен 0}
      for j := 1 to length(s) do {цикл деления числа}
        begin
          c := c * 10 - ord('0') + ord(s[j]); {приписываем к остатку текущую цифру}
          t := t + inttostr(c div i); {находим текущую цифру частного}
          c := c mod i {находим следующий остаток}
        end;
      if c = 0 then {если последний остаток равен 0, то}
        begin {число делится на текущий делитель, разбираемся с делителем}
          if d[k] <> i then {если новый делитель, то}
            begin
              inc(k); {увеличиваем номер делителя}
              d[k] := i {и записываем текущий делитель в массив}
            end;
          inc(p[k]); {подсчитываем количество текущих делителей}
          while t[1] = '0' do delete(t, 1, 1); {убираем из частного незначащие нули}
          s := t {и переписываем его в делимое}
        end
      else inc(i); {иначе, если последний остаток не равен 0, увеличиваем делитель на 1}
    end;
  {печатаем простые делители}
  writeln('Prime divisors:');
  writeln(hor);
  writeln('|  # | divisor | max power |');
  writeln(hor);
  for j := 1 to k do writeln('|', j:3, ' |',  d[j]:7, '|':3, p[j]:6, '|':6);
  writeln(hor);
  {находим и печатаем общее количество делителей}
  q := 1;
  for j := 1 to k do q := q * (p[j] + 1);
  writeln;
  write('Total quantity of all divisors = ', q)
end.  