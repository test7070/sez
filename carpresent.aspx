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
    <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
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

        function mainPost() { 
            q_getFormat();
            bbmMask = [['txtDatea', r_picd]];
            q_mask(bbmMask);
            //工具隱藏
            //$('#btnIns').hide();//新增
            $('#btnIns').val("未出車匯入");
            $('#btnSeek').hide();//查詢
            //$('#btnPrint').hide();//列印
            //$('#btnAuthority').hide();//權限
            $('#btnSign').hide();//簽核
            $('#tbbm').hide();//BBM隱藏
			
			$('#lblClose_divImportdate').click(function(e) {//按下關閉
				$('#divImportdate').hide();
			});
			$('#lbl_divImport').click(function(e) {//按下資料匯入
				$('#divImportdate').hide();
				if(!emp($('#txtBdate').val())&&!emp($('#txtEdate').val())){
					//q_func("dtable.dele", "carpresents,datea >=^^"+$('#txtBdate').val()+"^^ and datea <=^^"+$('#txtEdate').val()+"^^ ");//刪除bbs重覆資料
					//q_func("dtable.dele", "carpresent,datea >=^^"+$('#txtBdate').val()+"^^ and datea <=^^"+$('#txtEdate').val()+"^^ ");//刪除bbm重覆資料
					t_date=$('#txtBdate').val();
					insimport=true;
		    		insdata();
		    	}
			});
			$('#txtBdate').mask('999/99/99');
            $('#txtBdate').datepicker();
            $('#txtEdate').mask('999/99/99');
            $('#txtEdate').datepicker();
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
		
		var t_date='';
		var insimport=false;
		function insdata() {
		    if(t_date<=$('#txtEdate').val()&&t_date!=''){
		    	//跳過六日
		    	if(new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay()==0||new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay()==6){
		    		//日期加一天
				    var nextdate=new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2)));
				    nextdate.setDate(nextdate.getDate() +1)
				    t_date=''+(nextdate.getFullYear()-1911)+'/';
				    //月份
				    if(nextdate.getMonth()+1<10)
				    	t_date=t_date+'0'+(nextdate.getMonth()+1)+'/';
				    else
				       	t_date=t_date+(nextdate.getMonth()+1)+'/';
				    //日期
				    if(nextdate.getDate()<10)
				    	t_date=t_date+'0'+(nextdate.getDate());
				    else
				     	t_date=t_date+(nextdate.getDate());
				     insdata();
				     return;
		    	}
		    	//呼叫已儲存的舊資料
		    	var t_where = "where=^^ datea='"+t_date+"' ^^";
			    q_gt('carpresent', t_where , 0, 0, 0, "", r_accy);
			    
		    	
			}else{
				insimport=false;
				location.href = location.href ;//重新整理
				return;
			}
		}
		var t_carpresents;
        function q_gtPost(t_name) {  
            switch (t_name) {
            	case 'car2_carteam':
            	//開始新增
            	_btnIns();
            	$('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
	            $('#txtDatea').val(t_date);
	            $('#txtWeek').val(weekday(new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay()));
	            $('#txtDatea').focus();
            	insimport=true;
            	//匯進資料
            	var as = _q_appendData("car2", "", true);
            	if(as[0]!=undefined&&t_carpresents[0]!=undefined){
            		for (var i = 0; i < t_carpresents.length; i++) {
            			for (var j = 0; j < as.length; j++) {
            				if(t_carpresents[i].carno==as[j].carno){//取代先前原因
            					as[j].memo=t_carpresents[i].memo;
            				}
            			}	
            		}
            	}
            	if(as[0]!=undefined&&t_carpresents[0]!=undefined){
            		q_gridAddRow(bbsHtm, 'tbbs', 'txtCarno,txtDriver,txtCarteam,txtMemo', as.length, as, 'carno,namea,team,memo', '');
            	}else{
            		q_gridAddRow(bbsHtm, 'tbbs', 'txtCarno,txtDriver,txtCarteam', as.length, as, 'carno,namea,team', '');
            	}
            	
            	$('#txtUnpresent').val(as.length);
            	for (var i = 0; i < q_bbsCount; i++) {
            		if(!emp($('#txtCarno_'+i).val()))
            		{
            			$('#txtDatea_'+i).val(t_date);
            			$('#txtWeek_'+i).val(weekday(new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay()));
            			chkshow(i);
            		}
            	}
            	
				//存檔
				btnOk();
				
				//日期加一天
			    var nextdate=new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2)));
			    nextdate.setDate(nextdate.getDate() +1)
			    t_date=''+(nextdate.getFullYear()-1911)+'/';
			    //月份
			    if(nextdate.getMonth()+1<10)
			    	t_date=t_date+'0'+(nextdate.getMonth()+1)+'/';
			    else
			       	t_date=t_date+(nextdate.getMonth()+1)+'/';
			    //日期
			    if(nextdate.getDate()<10)
			    	t_date=t_date+'0'+(nextdate.getDate());
			    else
			     	t_date=t_date+(nextdate.getDate());
				
            	break;
            	
                case q_name: 
                	 if(insimport){
                	 	insimport=false;
                	 	t_carpresents=[];
                		var as = _q_appendData("carpresent", "", true);
                		if(as[0]!=undefined){
                			t_carpresents = _q_appendData("carpresents", "", true);
                			if(t_carpresents[0]!=undefined){
	                			for (var i = 0; i < t_carpresents.length; i++) {
	                				if(t_carpresents[i].memo==''){//只保留有原因的資料
			                        	t_carpresents.splice(i, 1);
			                        	i--;
			                        }
	                    		}
                			}
                		}
                		
                		q_func("dtable.dele", "carpresents,datea =^^"+t_date+"^^ ");//刪除bbs重覆資料
						q_func("dtable.dele", "carpresent,datea =^^"+t_date+"^^ ");//刪除bbm重覆資料
                		
		                //呼叫要匯入的資料
						var t_where = "where=^^ a.cartype='2' and len( carno)=6 AND CHARINDEX( '-',carno) > 0 and len(outdate)=0 and len(suspdate)=0 and carno not in (select noa from carChange where len(enddate)>0 or len(wastedate)>0 or len(canceldate)>0) ";
						t_where=t_where+"and a.carno not in (select carno from trans"+r_accy+" where carno in(select noa from car2 where cartype='2') and datea='"+t_date+"' group by carno) and a.driverno!=''^^";
					    q_gt('car2_carteam', t_where , 0, 0, 0, "", r_accy);
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
        	if ($('#divImportdate').is(":hidden")) {
				$('#divImportdate').show();
				$('#txtBdate').val(q_date());
				$('#txtEdate').val(q_date());
			} else{
				$('#divImportdate').hide();
        	}

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
			q_box('z_carpresent.aspx', '', "95%", "800px", q_getMsg("popPrint"));
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
				if(!emp($('#txtCarno_'+j).val()))
					chksum++;
            }  // j
            
            $('#txtUnpresent').val(chksum);
        }

        ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
        function refresh(recno) {
            _refresh(recno);
            //繼續新增資料
          if(insimport)
          	insdata();
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
        	$('#chkMemo1_'+id).hide();
        	$('#chkMemo2_'+id).hide();
        	$('#chkMemo3_'+id).hide();
        	$('#chkMemo4_'+id).hide();
        	$('#chkMemo5_'+id).hide();
        	$('#chkMemo6_'+id).hide();
        	$('#labmemo1_'+id).hide();
        	$('#labmemo2_'+id).hide();
        	$('#labmemo3_'+id).hide();
        	$('#labmemo4_'+id).hide();
        	$('#labmemo5_'+id).hide();
        	$('#labmemo6_'+id).hide();
        }
        function chkshow(id)
        {
        	$('#chkMemo1_'+id).show();
        	$('#chkMemo2_'+id).show();
        	$('#chkMemo3_'+id).show();
        	$('#chkMemo4_'+id).show();
        	$('#chkMemo5_'+id).show();
        	$('#chkMemo6_'+id).show();
        	$('#labmemo1_'+id).show();
        	$('#labmemo2_'+id).show();
        	$('#labmemo3_'+id).show();
        	$('#labmemo4_'+id).show();
        	$('#labmemo5_'+id).show();
        	$('#labmemo6_'+id).show();
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
            
            .popDiv {
				position: absolute;
				z-index: 99;
				background: #4297D7;
				border: 2px #EEEEEE solid;
				display: none;/*default*/
			}
			.popDiv .block {
				border-radius: 5px;
			}
			.popDiv .block .col {
				display: block;
				width: 600px;
				height: 30px;
				margin-top: 5px;
				margin-left: 5px;
			}
      		.btnLbl {
				background: #cad3ff;
				border-radius: 5px;
				display: block;
				width: 95px;
				height: 25px;
				cursor: default;
			}
			.btnLbl.tb {
				float: right;
			}
			.btnLbl.button {
				cursor: pointer;
				background: #76A2FE;
			}
			.btnLbl.button.close {
				background: #cad3ff;
			}
			.btnLbl.button:hover {
				background: #FF8F19;
			}
			.btnLbl a {
				color: blue;
				font-size: medium;
				height: 25px;
				line-height: 25px;
				display: block;
				text-align: center;
			}
			.btnLbl.button a {
				color: #000000;
			}
			.btnLbl.close a {
				color: red;
				font-size: 16px;
				height: 25px;
				line-height: 25px;
				display: block;
				text-align: center;
			}
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
		<div id="divImportdate" class='popDiv'>
			<table  border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;width:300px">
	            <tr>
	                <td align="center" style="width:30%"><span> </span><a id="lblImportdate" class="lbl" ></a></td>
	                <td align="center" style="width:70%">
	                	<input id="txtBdate" type="text"  class="txt c2" style=" float: left;"/>~
	                	<input id="txtEdate" type="text"  class="txt c2"  style=" float: right;"/>
	                </td>
	            </tr>
	            <tr>
	            	<td align="center" colspan="2">
	            		<div class="block" style="display: table-cell;">
		            		<div class='btnLbl button close' style="float: left;">
								<a id='lbl_divImport'></a>
							</div>
							<div style="float: left;width: 10px;height: 25px;">	</div>
							<div class='btnLbl button close' style="float: left;">
								<a id='lblClose_divImportdate'></a>
							</div>
						</div>
	                </td>
	            </tr>
        	</table>
		</div>
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
                <td align="center" class="td2" style="width:10%;"><a id='lblDrivers'></a></td>
                <td align="center" class="td3"><a id='lblMemos'></a></td>
            </tr>
            <tr>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td ><input class="txt c1" id="txtDatea.*" type="text" /><input class="txt c1" id="txtNoq.*" type="hidden" /></td>
                <td ><input class="txt c1" id="txtWeek.*" type="text" /></td>
                <td ><input class="txt c1" id="txtCarno.*" type="text" /></td>
                <td >
                	<input class="txt c1" id="txtDriver.*" type="text" />
                	<input class="txt c1" id="txtCarteam.*" type="hidden" />
                </td>
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
