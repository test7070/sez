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
        var q_name = "labsal";
        var q_readonly = [];
        var q_readonlys = [];
        var bbmNum = [['txtInsur_accident',5,1,1],['txtInsur_job',5,1,1],['txtInsur_person',5,1,1],['txtInsur_comp',5,1,1]];  
        var bbsNum = [['txtSalary1',10,0,1],['txtSalary2',10,0,1],['txtLmoney',10,0,1],['txtLself',10,0,1],['txtLcomp',10,0,1],['txtFlself',10,0,1],['txtFlcomp',10,0,1]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'noa';
        //ajaxPath = ""; 

        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();  
            q_gt(q_name, q_content, q_sqlCount, 1)  
        });
        
        function currentData() {}
			currentData.prototype = {
				data : [],
				/*新增時複製的欄位*/
				//bbm
				include : ['txtInsur_accident', 'txtInsur_person','txtInsur_job','txtInsur_comp'],
				//bbs
				includes : ['txtClass_', 'txtSalary1_','txtSalary2_','txtLmoney_','txtLself_','txtLcomp_','txtFlself_','txtFlcomp_'],
				/*記錄當前的資料*/
				copy : function() {
					this.data = new Array();
					for (var i in fbbm) {
						var isInclude = false;
						for (var j in this.include) {
							if (fbbm[i] == this.include[j] ) {
								isInclude = true;
								break;
							}
						}
						if (isInclude ) {
							this.data.push({
								field : fbbm[i],
								value : $('#' + fbbm[i]).val()
							});
						}
					}
					//bbs
					for (var i in this.includes) {
						for(var j = 0; j < q_bbsCount; j++) {
							this.data.push({
								field : this.includes[i]+j,
								value : $('#' + this.includes[i]+j).val()
							});
						}
					}
				},
				/*貼上資料*/
				paste : function() {
					for (var i in this.data) {
					   	$('#' + this.data[i].field).val(this.data[i].value);
				   	}
				}
			};
			
			var curData = new currentData();

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
            bbmMask = [['txtNoa', r_picd]];
            q_mask(bbmMask);
            
            $('#txtInsur_accident').change(function () {
            	for (var j = 0; j < q_bbsCount; j++) {
            		if(!emp($('#txtLmoney_'+j).val())){
						q_tr('txtFlself_'+j,Math.round(dec($('#txtLmoney_'+j).val())*(dec($('#txtInsur_person').val())/100)*(dec($('#txtInsur_accident').val())/100)));//外勞個人負擔
						q_tr('txtFlcomp_'+j,Math.round(dec($('#txtLmoney_'+j).val())*(dec($('#txtInsur_comp').val())/100)*(dec($('#txtInsur_accident').val())/100)));//外勞公司負擔
						q_tr('txtLself_'+j,dec($('#txtFlself_'+j).val())+Math.round(dec($('#txtLmoney_'+j).val())*(dec($('#txtInsur_person').val())/100)*(dec($('#txtInsur_job').val())/100)));//個人負擔
						q_tr('txtLcomp_'+j,dec($('#txtFlcomp_'+j).val())+Math.round(dec($('#txtLmoney_'+j).val())*(dec($('#txtInsur_comp').val())/100)*(dec($('#txtInsur_job').val())/100)));//公司負擔
					}
            	}
            });
            $('#txtInsur_job').change(function () {
            	for (var j = 0; j < q_bbsCount; j++) {
            		if(!emp($('#txtLmoney_'+j).val())){
						q_tr('txtLself_'+j,dec($('#txtFlself_'+j).val())+Math.round(dec($('#txtLmoney_'+j).val())*(dec($('#txtInsur_person').val())/100)*(dec($('#txtInsur_job').val())/100)));//個人負擔
						q_tr('txtLcomp_'+j,dec($('#txtFlcomp_'+j).val())+Math.round(dec($('#txtLmoney_'+j).val())*(dec($('#txtInsur_comp').val())/100)*(dec($('#txtInsur_job').val())/100)));//公司負擔
					}
            	}
            });
            $('#txtInsur_person').change(function () {
            	for (var j = 0; j < q_bbsCount; j++) {
            		if(!emp($('#txtLmoney_'+j).val())){
						q_tr('txtFlself_'+j,Math.round(dec($('#txtLmoney_'+j).val())*(dec($('#txtInsur_person').val())/100)*(dec($('#txtInsur_accident').val())/100)));//外勞個人負擔
						q_tr('txtLself_'+j,dec($('#txtFlself_'+j).val())+Math.round(dec($('#txtLmoney_'+j).val())*(dec($('#txtInsur_person').val())/100)*(dec($('#txtInsur_job').val())/100)));//個人負擔
					}
            	}
            });
            $('#txtInsur_comp').change(function () {
            	for (var j = 0; j < q_bbsCount; j++) {
            		if(!emp($('#txtLmoney_'+j).val())){
						q_tr('txtFlcomp_'+j,Math.round(dec($('#txtLmoney_'+j).val())*(dec($('#txtInsur_comp').val())/100)*(dec($('#txtInsur_accident').val())/100)));//外勞公司負擔
						q_tr('txtLcomp_'+j,dec($('#txtFlcomp_'+j).val())+Math.round(dec($('#txtLmoney_'+j).val())*(dec($('#txtInsur_comp').val())/100)*(dec($('#txtInsur_job').val())/100)));//公司負擔
					}
            	}
            });
        }

        function q_boxClose(s2) {
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
                case q_name: 
                	if (q_cur == 1){
                		
                	}
                	if (q_cur == 4)  
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }

        function btnOk() {
        	$('#txtNoa').val($.trim($('#txtNoa').val()));
                if (checkId($('#txtNoa').val())==0){
                	alert(q_getMsg('lblNoa')+'錯誤。');
                	return;
            }
        	
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }

            $('#txtWorker').val(r_name)
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('labsal_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
        }

        function bbsAssign() {  
        	for (var j = 0; j < q_bbsCount; j++) {
        		if (!$('#btnMinus_' + j).hasClass('isAssign')) {
        			$('#txtSalary2_'+j).change(function () {
        				 t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                 q_bodyId($(this).attr('id'));
		                 b_seq = t_IdSeq;
        				if(!emp($('#txtSalary2_'+b_seq).val())){
							q_tr('txtLmoney_'+b_seq,$('#txtSalary2_'+b_seq).val());
							q_tr('txtFlself_'+b_seq,Math.round(dec($('#txtLmoney_'+b_seq).val())*(dec($('#txtInsur_person').val())/100)*(dec($('#txtInsur_accident').val())/100)));//外勞個人負擔
							q_tr('txtFlcomp_'+b_seq,Math.round(dec($('#txtLmoney_'+b_seq).val())*(dec($('#txtInsur_comp').val())/100)*(dec($('#txtInsur_accident').val())/100)));//外勞公司負擔
							q_tr('txtLself_'+b_seq,dec($('#txtFlself_'+b_seq).val())+Math.round(dec($('#txtLmoney_'+b_seq).val())*(dec($('#txtInsur_person').val())/100)*(dec($('#txtInsur_job').val())/100)));//個人負擔
							q_tr('txtLcomp_'+b_seq,dec($('#txtFlcomp_'+b_seq).val())+Math.round(dec($('#txtLmoney_'+b_seq).val())*(dec($('#txtInsur_comp').val())/100)*(dec($('#txtInsur_job').val())/100)));//公司負擔
						}
        			});
        			$('#txtLmoney_'+j).change(function () {
        				 t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                 q_bodyId($(this).attr('id'));
		                 b_seq = t_IdSeq;
        				if(!emp($('#txtLmoney_'+b_seq).val())){
							q_tr('txtFlself_'+b_seq,Math.round(dec($('#txtLmoney_'+b_seq).val())*(dec($('#txtInsur_person').val())/100)*(dec($('#txtInsur_accident').val())/100)));//外勞個人負擔
							q_tr('txtFlcomp_'+b_seq,Math.round(dec($('#txtLmoney_'+b_seq).val())*(dec($('#txtInsur_comp').val())/100)*(dec($('#txtInsur_accident').val())/100)));//外勞公司負擔
							q_tr('txtLself_'+b_seq,dec($('#txtFlself_'+b_seq).val())+Math.round(dec($('#txtLmoney_'+b_seq).val())*(dec($('#txtInsur_person').val())/100)*(dec($('#txtInsur_job').val())/100)));//個人負擔
							q_tr('txtLcomp_'+b_seq,dec($('#txtFlcomp_'+b_seq).val())+Math.round(dec($('#txtLmoney_'+b_seq).val())*(dec($('#txtInsur_comp').val())/100)*(dec($('#txtInsur_job').val())/100)));//公司負擔
						}
        			});
				}
            }
            _bbsAssign();
        }

        function btnIns() {
        	var t_bbscounts=q_bbsCount;
			if($('#Copy').is(':checked')){
				curData.copy();
			}
            _btnIns();
            if($('#Copy').is(':checked')){
				while(t_bbscounts>=q_bbsCount){
					q_bbs_addrow('bbs',0,0);
				}
				curData.paste();
			}
            $('#txtNoa').focus();
            $('#txtNoa').val(q_date());
        }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
        }
        function btnPrint() {

        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {   
            if (!as['class']) {  
                as[bbsKey[1]] = '';   
                return;
            }

            q_nowf();
            as['date'] = abbm2['date'];

            //            t_err ='';
            //            if (as['total'] != null && (dec(as['total']) > 999999999 || dec(as['total']) < -99999999))
            //                t_err = q_getMsg('msgMoneyErr') + as['total'] + '\n';

            //            
            //            if (t_err) {
            //                alert(t_err)
            //                return false;
            //            }
            //            
            return true;
        }

        function sum() {
            var t1 = 0, t_unit, t_mount, t_weight = 0;
            for (var j = 0; j < q_bbsCount; j++) {

            }  // j
        }
        /////////////////////////////////////////////////// 
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
        function checkId(str) {
                if ((/^[a-z,A-Z][0-9]{9}$/g).test(str)) {//身分證字號
                    var key = 'ABCDEFGHJKLMNPQRSTUVWXYZIO';
                    var s = (key.indexOf(str.substring(0, 1)) + 10) + str.substring(1, 10);
                    var n = parseInt(s.substring(0, 1)) * 1 + parseInt(s.substring(1, 2)) * 9 + parseInt(s.substring(2, 3)) * 8 + parseInt(s.substring(3, 4)) * 7 + parseInt(s.substring(4, 5)) * 6 + parseInt(s.substring(5, 6)) * 5 + parseInt(s.substring(6, 7)) * 4 + parseInt(s.substring(7, 8)) * 3 + parseInt(s.substring(8, 9)) * 2 + parseInt(s.substring(9, 10)) * 1 + parseInt(s.substring(10, 11)) * 1;
                    if ((n % 10) == 0)
                        return 1;
                } else if ((/^[0-9]{8}$/g).test(str)) {//統一編號
                    var key = '12121241';
                    var n = 0;
                    var m = 0;
                    for (var i = 0; i < 8; i++) {
                        n = parseInt(str.substring(i, i + 1)) * parseInt(key.substring(i, i + 1));
                        m += Math.floor(n / 10) + n % 10;
                    }
                    if ((m % 10) == 0 || ((str.substring(6, 7) == '7' ? m + 1 : m) % 10) == 0)
                        return 2;
                }else if((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//西元年
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 3;
                }else if((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//民國年
                	str = (parseInt(str.substring(0,3))+1911)+str.substring(3);
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 4
               	}
               	return 0;//錯誤
            }


    </script>
    <style type="text/css">
        #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 28%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
                width: 100%;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 70%;
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
                width: 11%;
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
                width: 70%;
                float: right;
            }
            .txt.c3 {
                width: 47%;
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
            .txt.c6 {
                width: 25%;
                
            }
            .txt.c7 {
                width: 95%;
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
            }
            .tbbm td input[type="button"] {
                float: left;
                width: auto;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .dbbs {
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
            }

            .num {
                text-align: right;
            }
            .tbbs tr.error input[type="text"] {
                color: red;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
        .tbbs
        {
            FONT-SIZE: medium;
            COLOR: blue ;
            TEXT-ALIGN: left;
             BORDER:1PX LIGHTGREY SOLID;
             width:100% ; height:98% ;  
        }  
      
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' >
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:20%"><a id='vewNoa'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='noa'>~noa</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr>
            <td class='td1'><span> </span><a id="lblNoa" class="lbl" > </a></td>
            <td class="td2"><input id="txtNoa"  type="text" class="txt c1"/></td>
            <td class="td1" style="text-align: center;">
            	<input id="Copy" type="checkbox" />
				<span> </span><a id="lblCopy">複製</a>
			</td>
        </tr>
        <tr>
            <td class='td1'><span> </span><a id="lblInsur_accident" class="lbl" > </a></td>
            <td class="td2"><input id="txtInsur_accident" type="text" class="txt num c1" /></td> 
            <td class='td3'><span> </span><a id="lblInsur_job" class="lbl" > </a></td>
            <td class="td4"><input id="txtInsur_job" type="text" class="txt num c1" /></td> 
        </tr>
        <tr>
            <td class='td1'><span> </span><a id="lblInsur_person" class="lbl" > </a></td>
            <td class="td2"><input id="txtInsur_person" type="text" class="txt num c1" /></td>
            <td class='td3'><span> </span><a id="lblInsur_comp" class="lbl"> </a></td>
            <td class="td4"><input id="txtInsur_comp" type="text" class="txt num c1" /></td>
        </tr>              
        </table>
        </div>

        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center"><a id='lblClass_s'> </a></td>
                <td align="center"><a id='lblSalary1_s'> </a></td>
                <td align="center"><a id='lblSalary2_s'> </a></td>
                <td align="center"><a id='lblLmoney_s'> </a></td>
                <td align="center"><a id='lblLself_s'> </a></td>
                <td align="center"><a id='lblLcomp_s'> </a></td>
                <td align="center"><a id='lblFlself_s'> </a></td>
                <td align="center"><a id='lblFlcomp_s'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td ><input class="txt c1" id="txtClass.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtSalary1.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtSalary2.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtLmoney.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtLself.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtLcomp.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtFlself.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtFlcomp.*" type="text" /><input id="txtNoq.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
