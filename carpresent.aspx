<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
    <title></title>
    <script src="../script/jquery.min.js" type="text/javascript"></script>
    <script src='../script/qj2.js' type="text/javascript"></script>
    <script src='qset.js' type="text/javascript"></script>
    <script src='../script/qj_mess.js' type="text/javascript"></script>
    <script src="../script/qbox.js" type="text/javascript"></script>
    <script src='../script/mask.js' type="text/javascript"></script>
    <link href="../qbox.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        this.errorHandler = null;
        function onPageError(error) {
            alert("An error occurred:\r\n" + error.Message);
        }
        q_tables = 's';
        var q_name = "carpresent";
        var q_readonly = [];
        var q_readonlys = [];
        var bbmNum = [];  
        var bbsNum = [];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'noa';
       
        aPop = new Array();        
        var today = new Date();//取得今天日期與時間
		//aPop = new Array(['txtBankno', 'lblBank', 'bank', 'noa,bank', 'txtBankno,txtBank', 'bank_b.aspx'],['txtBank_', 'btnBank_', 'bank', 'noa,bank', 'txtBankno_,txtBank_', 'bank_b.aspx']);
        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            brwCount2 = 10;
            q_desc=1;
            q_brwCount();
            q_gt(q_name, q_content, q_sqlCount, 1);
          });

        //////////////////   end Ready
        function main() {
            if (dataErr)  
            {
                dataErr = false;
                return;
            }

            mainForm(1); 
        }  
		var today_unpresent=[];
		var Unbtn=false;//讓開始匯入資料時不判斷今天是否已匯入未出車
        function mainPost() { 
            q_getFormat();
            bbmMask = [['txtDatea', r_picd]];
            q_mask(bbmMask);
            //工具隱藏
            $('#btnIns').attr('hidden', 'true');//新增
            $('#btnSeek').attr('hidden', 'true');//查詢
            $('#btnPrint').attr('hidden', 'true');//列印
            $('#btnAuthority').attr('hidden', 'true');//權限
            $('#btnSign').attr('hidden', 'true');//簽核
            $('#tbbm').attr('hidden', 'true');//BBM隱藏

             $('#btnUnpresent').click(function (e) {
             	today = new Date();//防止更改日期
             	//讀取今天是否以新增過未出車
            	var t_where = "where=^^ datea='"+q_date()+"' ^^";
            	q_gt(q_name, t_where , 0, 0, 0, "", r_accy);
            	Unbtn=true;
		     });
        }

        function q_boxClose(s2) { ///   q_boxClose 2/4 
            var ret;
            switch (b_pop) {   
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
            b_pop = '';
        }


        function q_gtPost(t_name) {  
            switch (t_name) {
            	case 'car2_carteam':
            	var as = _q_appendData("car2", "", true);
            	q_gridAddRow(bbsHtm, 'tbbs', 'txtCarno,txtCarteam', as.length, as, 'carno,team', '');
            	$('#txtUnpresent').val(as.length);
            	for (var i = 0; i < q_bbsCount; i++) {
            		if(!emp($('#txtCarno_'+i).val()))
            		{
            			$('#txtDatea_'+i).val(q_date());
            			$('#txtWeek_'+i).val(weekday(today.getDay()));
            			chkshow(i);
            		}
            	}
            	
            	break;
                case q_name: 
                	if(Unbtn){
	                	today_unpresent = _q_appendData(q_name, "", true);
	                	if(today_unpresent[0]==undefined)
	                	{		
			           	 	btnIns();      
			            	var t_where = "where=^^ a.cartype='2' and a.carno not in (select carno from trans101 where carno in(select noa from car2 where cartype='2') and datea='"+q_date()+"' group by carno) ^^";
	            			q_gt('car2_carteam', t_where , 0, 0, 0, "", r_accy);    
						}else{
							alert("今天已匯入未出車資料");
	                		return;
						}
					}
                	
                	if (q_cur == 4)   
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }

        function btnOk() {
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }
            sum();

			//$('#txtUnpresent').val(q_bbsCount);
			var t_carnos='';
			for (var i = 0; i < 5; i++) {
				if(!emp($('#txtCarno_'+i).val()))
					t_carnos=t_carnos+$('#txtCarno_'+i).val()+',';
			}
			$('#txtCarno').val(t_carnos+"...");
			
			var t_memos='';
			for (var i = 0; i < 5; i++) {
				if(!emp($('#txtMemo_'+i).val()))
					t_memos=t_memos+$('#txtMemo_'+i).val()+',';
			}
			$('#txtMemo').val(t_memos+"...");
			
            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   
                q_gtnoa(q_name, replaceAll('G' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;
        }

        function combPay_chg() {   
        }

        function bbsAssign() {
            for (var i = 0; i < q_bbsCount; i++) {
            	$('#txtMemo_' + i).change(function () {
            		t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                    q_bodyId($(this).attr('id'));
                    b_seq = t_IdSeq;
            		if(emp($('#txtMemo_' + b_seq).val()))
            			chkshow(b_seq);
            		else
            			chkhidden(b_seq);
            	});
            	$('#chkMemo1_'+i).click(function() {
        			 t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                    q_bodyId($(this).attr('id'));
                    b_seq = t_IdSeq;
        			$('#txtMemo_'+b_seq).val("司機請假");        			
        			chkhidden(b_seq);
        		});
        		$('#chkMemo2_'+i).click(function() {
        			 t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                    q_bodyId($(this).attr('id'));
                    b_seq = t_IdSeq;
        			$('#txtMemo_'+b_seq).val("本日無工作");        			
        			chkhidden(b_seq);
        		});
        		$('#chkMemo3_'+i).click(function() {
        			 t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                    q_bodyId($(this).attr('id'));
                    b_seq = t_IdSeq;
        			$('#txtMemo_'+b_seq).val("車輛維修");        			
        			chkhidden(b_seq);
        		});
        		$('#chkMemo4_'+i).click(function() {
        			 t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                    q_bodyId($(this).attr('id'));
                    b_seq = t_IdSeq;
        			$('#txtMemo_'+b_seq).val("檢驗車輛");        			
        			chkhidden(b_seq);
        		});
        		$('#chkMemo5_'+i).click(function() {
        			 t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                    q_bodyId($(this).attr('id'));
                    b_seq = t_IdSeq;
        			$('#txtMemo_'+b_seq).val("無司機");        			
        			chkhidden(b_seq);
        		});
        		$('#chkMemo6_'+i).click(function() {
        			 t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                    q_bodyId($(this).attr('id'));
                    b_seq = t_IdSeq;
        			$('#txtMemo_'+b_seq).val("其他,請註明");        			
        			chkhidden(b_seq);
        		});
            }//end for
            _bbsAssign();
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtDatea').val(q_date());
            $('#txtWeek').val(weekday(today.getDay()));
            $('#txtDatea').focus();

        }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();

	            for (var j = 0; j < q_bbsCount; j++) {
	            	if(!emp($('#txtMemo_'+j).val()))
	            		chkhidden(j);
	            	else
	            		chkshow(j);
	            }
        }
        function btnPrint() {

        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {
            if (!as['carno'] ) {  
                as[bbsKey[1]] = '';   
                return;
            }

            q_nowf();
            as['date'] = abbm2['date'];
            return true;
        }

        function sum() {
            var t1 = 0, t_unit, t_mount, t_weight = 0,chksum=0;
            for (var j = 0; j < q_bbsCount; j++) {

            }  // j
        }

        ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
        function refresh(recno) {
            _refresh(recno);
       }
		
        function readonly(t_para, empty) {
            _readonly(t_para, empty);
        }

        function btnMinus(id) {
            _btnMinus(id);
            sum();
        }

        function btnPlus(org_htm, dest_tag, afield) {
            _btnPlus(org_htm, dest_tag, afield);
            if (q_tables == 's')
                bbsAssign();  /// 表身運算式 
        }

        function q_appendData(t_Table) {
            return _q_appendData(t_Table);
        }

        function btnSeek() {
            _btnSeek();
        }

        function btnTop() {
            _btnTop();
        }
        function btnPrev() {
            _btnPrev();
        }
        function btnPrevPage() {
            _btnPrevPage();
        }

        function btnNext() {
            _btnNext();
        }
        function btnNextPage() {
            _btnNextPage();
        }

        function btnBott() {
            _btnBott();
        }
        function q_brwAssign(s1) {
            _q_brwAssign(s1);
        }

        function btnDele() {
            _btnDele();
        }

        function btnCancel() {
            _btnCancel();
        }
        
        function chkhidden(id)
        {
        	$('#chkMemo1_'+id).attr('hidden', 'true');
        	$('#chkMemo2_'+id).attr('hidden', 'true');
        	$('#chkMemo3_'+id).attr('hidden', 'true');
        	$('#chkMemo4_'+id).attr('hidden', 'true');
        	$('#chkMemo5_'+id).attr('hidden', 'true');
        	$('#chkMemo6_'+id).attr('hidden', 'true');
        	$('#labmemo1_'+id).attr('hidden', 'true');
        	$('#labmemo2_'+id).attr('hidden', 'true');
        	$('#labmemo3_'+id).attr('hidden', 'true');
        	$('#labmemo4_'+id).attr('hidden', 'true');
        	$('#labmemo5_'+id).attr('hidden', 'true');
        	$('#labmemo6_'+id).attr('hidden', 'true');
        }
        function chkshow(id)
        {
        	$('#chkMemo1_'+id).removeAttr('hidden');
        	$('#chkMemo2_'+id).removeAttr('hidden');
        	$('#chkMemo3_'+id).removeAttr('hidden');
        	$('#chkMemo4_'+id).removeAttr('hidden');
        	$('#chkMemo5_'+id).removeAttr('hidden');
        	$('#chkMemo6_'+id).removeAttr('hidden');
        	$('#labmemo1_'+id).removeAttr('hidden');
        	$('#labmemo2_'+id).removeAttr('hidden');
        	$('#labmemo3_'+id).removeAttr('hidden');
        	$('#labmemo4_'+id).removeAttr('hidden');
        	$('#labmemo5_'+id).removeAttr('hidden');
        	$('#labmemo6_'+id).removeAttr('hidden');
        }
        function weekday(wd)
		{
		   switch(wd)
		   {
		      case 1: return("一"); break;
		      case 2: return("二"); break;
		      case 3: return("三"); break;
		      case 4: return("四"); break;
		      case 5: return("五"); break;
		      case 6: return("六"); break;
		      case 0: return("日"); break;
		   }
		}
        
    </script>
    <style type="text/css">
        #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 98%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 98%;
                margin: -1px;
                border: 1px black solid;
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr td {
                width: 9%;
            }
            .tbbm .tdZ {
                width: 2%;
            }
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: blue;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 38%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
                float: left;
            }
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
                float: left;
            }
            .txt.num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
           
           
           .tbbs tr.sel { background:yellow;} 
           .tbbs tr.chksel { background:bisque;} 
           
             .dbbs .tbbs{margin:0;padding:2px;border:2px lightgrey double;border-spacing:1px;border-collapse:collapse;font-size:medium;color:blue;background:#cad3ff;width:100%;}
			 .dbbs .tbbs tr{height:35px;}
			 .dbbs .tbbs tr td{text-align:center;border:2px lightgrey double;}
        	    
             input[type="text"],input[type="button"] {     
                font-size: medium;
            }
      
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
		<input type="button" id="btnUnpresent" />
        <div id='dmain'>
        <div class="dview" id="dview" style="float: left;  width:100%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66; width:100%;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:10%"><a id='vewDatea'></a></td>
                <td align="center" style="width:10%"><a id='vewWeek'></a></td>
                <td align="center" style="width:10%"><a id='vewUnpresent'></a></td>
                <td align="center"><a id='vewCarno'></a></td>
                <td align="left"><a id='vewMemo'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='week'>~week</td>
                   <td align="center" id='unpresent'>~unpresent</td>
                   <td align="center" id='carno'>~carno</td>
                   <td align="center" id='memo'>~memo</td>
            </tr>
        </table>
        </div>
        
		<div class='dbbm' style="float:left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0' >
        <tr>
            <td class='td1'><span> </span><a id="lblNoa" class="lbl" ></a></td>
            <td class="td2"><input id="txtNoa"type="text" class="txt c1"/></td>
            <td class='td3'><span> </span><a id="lblDatea" class="lbl"></a></td>
            <td class="td4"><input id="txtDatea"  type="text" class="txt c1"/></td>
            <td class='td5'><span> </span><a id="lblWeek" class="lbl" ></a></td>
            <td class="td6"><input id="txtWeek" type="text"  class="txt c2"/></td>
        </tr>
        <tr>            
            <td class='td1'><span> </span><a id="lblUnpresent" class="lbl" ></a></td>
            <td class="td2"><input id="txtUnpresent" type="text"  class="txt c1"/></td>
            <td class='td3'><span> </span><a id="lblCarno" class="lbl" ></a></td>
            <td class="td4"><input id="txtCarno" type="text" class="txt c1" /></td>
            <td class='td5'><span> </span><a id="lblMemo" class="lbl" ></a></td>
            <td class="td6"><input id="txtMemo" type="text" class="txt c1" /></td>
            </tr>             
        </table>
        </div>

        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center" class="td2" style="width:10%;"><a id='lblDateas'></a></td>
                <td align="center" style="width:10%;"><a id='lblWeeks'></a></td>
                <td align="center" class="td3" style="width:10%;"><a id='lblCarnos'></a></td>
                <td align="center" class="td2" style="width:10%;"><a id='lblCarteams'></a></td>
                <td align="center" class="td3"><a id='lblMemos'></a></td>
            </tr>
            <tr>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td ><input class="txt c1" id="txtDatea.*" type="text" /></td>
                <td ><input class="txt c1" id="txtWeek.*" type="text" /></td>
                <td ><input class="txt c1" id="txtCarno.*" type="text" /></td>
                <td ><input class="txt c1" id="txtCarteam.*" type="text" /></td>
                <td ><input class="txt c1" id="txtMemo.*" type="text" />
                		<input id="chkMemo1.*" type="checkbox" hidden="true"/><label id="labmemo1.*" hidden="true">司機請假</label>
                		<input id="chkMemo2.*" type="checkbox" hidden="true"/><label id="labmemo2.*" hidden="true">本日無工作</label>
                		<input id="chkMemo3.*" type="checkbox" hidden="true"/><label id="labmemo3.*" hidden="true">車輛維修</label>
                		<input id="chkMemo4.*" type="checkbox" hidden="true"/><label id="labmemo4.*" hidden="true">檢驗車輛</label>
                		<input id="chkMemo5.*" type="checkbox" hidden="true"/><label id="labmemo5.*" hidden="true">無司機</label>
                		<input id="chkMemo6.*" type="checkbox" hidden="true"/><label id="labmemo6.*" hidden="true">其他,請註明</label>
                </td>
            </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
