<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
    <title> </title>
    <script src="../script/jquery.min.js" type="text/javascript"> </script>
    <script src='../script/qj2.js' type="text/javascript"> </script>
        <script src='qset.js' type="text/javascript"> </script>
    <script src='../script/qj_mess.js' type="text/javascript"> </script>
    <script src="../script/qbox.js" type="text/javascript"> </script>
    <script src='../script/mask.js' type="text/javascript"> </script>
    <link href="../qbox.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        this.errorHandler = null;
        function onPageError(error) {
            alert("An error occurred:\r\n" + error.Message);
        }
        q_tables = 's';
        var q_name = "salother";
        var q_readonly = ['txtNoa'];
        var q_readonlys = [];
        var bbmNum = [['txtTotal',15,0,1]];  
        var bbsNum = [['txtBo_borns',15,0,1],['txtBo_night',15,0,1],['txtBo_day',15,0,1],['txtOth_dutyfree',15,0,1],['txtOth_tax',15,0,1],['txtBorr',15,0,1],['txtCh_power',15,0,1],['txtChgcash',15,0,1],['txtCh_stay',15,0,1],['txtTotal',15,0,1]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'noa';
        q_desc=1;
		aPop = new Array(['txtSssno_', 'txtSssno_', 'sss', 'noa,namea', 'txtSssno_,txtNamea_', 'sss_b.aspx']);
        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            
            q_brwCount();   

            q_gt(q_name, q_content, q_sqlCount, 1)  

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
            bbmMask = [['txtMon', r_picm]];
            q_mask(bbmMask);
            
            q_cmbParse("cmbPerson", q_getPara('person.typea'));
            q_cmbParse("cmbMonkind", ('').concat(new Array('上期', '下期', '本月')));
            
            $('#cmbPerson').change(function () {
            	 if ($('#cmbPerson').find("option:selected").text().indexOf('外勞')>-1){
            	 	q_cmbParse("cmbMonkind", ('').concat(new Array('本月')));
            	 }else{
            	 	q_cmbParse("cmbMonkind", ('').concat(new Array('上期', '下期')));
            	 }
            	 table_change();
            	 check_insed();
            });
            
            $('#cmbMonkind').change(function () {
            	check_insed();
            });
            
            $('#btnInput').click(function () {
            	var t_where = "where=^^ person='"+$('#cmbPerson').find("option:selected").text()+"' ^^";
		        q_gt('sss', t_where , 0, 0, 0, "", r_accy);
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
            	case 'sss':
            			var date_1='';
            			if($('#cmbMonkind').find("option:selected").text().indexOf('下期')>-1){
        					date_1=$('#txtMon').val()+'/16';
        				}else{
        					date_1=$('#txtMon').val()+'/01';
        				}
            			var as = _q_appendData("sss", "", true);
						for (var i = 0; i < as.length; i++) {
							//判斷是否哪些員工要寫入
		                    if ((!emp(as[i].ft_date) && as[i].ft_date >date_1)||(!emp(as[i].outdate)&&as[i].outdate<date_1||as[i].indate>$('#txtMon').val())) {
		                        as.splice(i, 1);
		                        i--;
		                    }
		                 }
		                 q_gridAddRow(bbsHtm, 'tbbs', 'txtSssno,txtNamea', as.length, as, 'noa,namea', '');
		                 table_change();
            	break;
                case q_name: 

                	if (q_cur == 4)   
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }

        function btnOk() {
			$('#txtMon').val($.trim($('#txtMon').val()));
				if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())){
					alert(q_getMsg('lblMon')+'錯誤。');   
					return;
			} 
			       	
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]); 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }
            
            if(insed&&q_cur==1){
            	alert('該其他項目作業已做過!!!');
                return;
            }

            $('#txtWorker').val(r_name)
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   
                q_gtnoa(q_name, replaceAll('O' + $('#txtMon').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('salother_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
        }

        function bbsAssign() { 
        	for(var j = 0; j < q_bbsCount; j++) {
           		if (!$('#btnMinus_' + j).hasClass('isAssign')) {
           			$('#txtBo_borns_'+j).change(function () {sum();});
           			$('#txtBo_night_'+j).change(function () {sum();});
           			$('#txtBo_day_'+j).change(function () {sum();});
           			$('#txtOth_dutyfree_'+j).change(function () {sum();});
           			$('#txtOth_tax_'+j).change(function () {sum();});
           			$('#txtBorr_'+j).change(function () {sum();});
           			$('#txtCh_power_'+j).change(function () {sum();});
           			$('#txtChgcash_'+j).change(function () {sum();});
           			$('#txtCh_stay_'+j).change(function () {sum();});
           			$('#txtMeal_'+j).change(function () {sum();});
            	}
            }
            _bbsAssign();
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtMon').val(q_date().substr( 0,6));
            $('#txtMon').focus();
            $('#cmbPerson').val("本國");
            $('#cmbMonkind').val("上期");
            check_insed();
            table_change();
        }
        
        var insed=false;
        function check_insed() {
        	if(q_cur==1){
        	 //判斷是否已新增過
           		var t_where = "where=^^ mon='"+$('#txtMon').val()+"' and person='"+$('#cmbPerson').find("option:selected").text()+"' and monkind='"+$('#cmbMonkind').find("option:selected").text()+"' ^^";
		    	q_gt('salother', t_where , 0, 0, 0, "", r_accy);
		    }
        }
        
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtMon').attr('disabled', 'disabled');
            $('#cmbPerson').attr('disabled', 'disabled');
            $('#cmbMonkind').attr('disabled', 'disabled');
        }
        function btnPrint() {

        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {   
            if (!as['sssno']) {  
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
            var t_total=0;
            for (var j = 0; j < q_bbsCount; j++) {
            	if($('#cmbPerson').find("option:selected").text().indexOf('外勞')>-1){
					q_tr('txtTotal_'+j,q_float('txtBo_borns_'+j)+q_float('txtBo_night_'+j)+q_float('txtBo_day_'+j)+q_float('txtOth_dutyfree_'+j)+q_float('txtOth_tax_'+j)+q_float('txtBorr_'+j)+q_float('txtChgcash_'+j)+q_float('txtCh_stay_'+j)+q_float('txtMeal_'+j));
				}else{
					q_tr('txtTotal_'+j,q_float('txtBo_borns_'+j)+q_float('txtBo_night_'+j)+q_float('txtBo_day_'+j)+q_float('txtOth_dutyfree_'+j)+q_float('txtOth_tax_'+j)+q_float('txtBorr_'+j)+q_float('txtCh_power_'+j)+q_float('txtMeal_'+j));
				}
				t_total+=dec($('#txtTotal_'+j).val());
            }  // j
            q_tr('txtTotal',t_total);
        }

        function refresh(recno) {
            _refresh(recno);
			table_change();
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
        
        function table_change() {
            if($('#cmbPerson').find("option:selected").text().indexOf('外勞')>-1){
			    //bbs
            	$('#hid_ch_powers').hide();
			    $('#hid_chgcashs').show();
			    $('#hid_ch_stays').show();
			    for (var j = 0; j < q_bbsCount; j++) {
			    	$('#hid_ch_powers_'+j).hide();
			    	$('#hid_chgcashs_'+j).show();
				    $('#hid_ch_stays_'+j).show();
			    }
            }else{
			    //bbs
            	$('#hid_ch_powers').show();
			    $('#hid_chgcashs').hide();
			    $('#hid_ch_stays').hide();
			    for (var j = 0; j < q_bbsCount; j++) {
			    	$('#hid_ch_powers_'+j).show();
			    	$('#hid_chgcashs_'+j).hide();
				    $('#hid_ch_stays_'+j).hide();
			    }
            }
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
                font-size: medium;
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
                <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                <td align="center" style="width:20%"><a id='vewMon'> </a></td>
                <td align="center" style="width:20%"><a id='vewPerson'> </a></td>
                
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='mon'>~mon</td>
                   <td align="center" id='person'>~person</td>
                  
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr class="tr1">
            <td class='td1'><span> </span><a id="lblMon" class="lbl" > </a></td>
            <td class="td2"><input id="txtMon"  type="text" class="txt c1"/></td>
            <td class='td3'><span> </span><a id="lblNoa" class="lbl" > </a></td>
            <td class="td4"><input id="txtNoa"  type="text" class="txt c1"/></td>
        </tr>             
        <tr class="tr2">
            <td class='td1'><span> </span><a id="lblPerson" class="lbl" > </a></td>
            <td class="td2"><select id="cmbPerson" class="txt c1"> </select></td>
            <td class="td3"><span> </span><a id="lblTypea" class="lbl"> </a></td>
            <td class='td4'><select id="cmbMonkind" class="txt c1"> </select></td>
            <td class="td2"><input id="btnInput"  type="button" class="txt c1"/></td>
        </tr>   
        <tr class="tr3">
            <td class='td1'><span> </span><a id="lblTotal" class="lbl" > </a></td>
            <td class="td2"><input id="txtTotal"  type="text" class="txt num c1"/></td> 
        </tr>                                                                                                    
        </table>
        </div>

        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center"><a id='lblSssno_s'> </a></td>
                <td align="center"><a id='lblNamea_s'> </a></td>
                <td align="center"><a id='lblBo_borns_s'> </a></td>
                <td align="center"><a id='lblBo_night_s'> </a></td>
                <td align="center"><a id='lblBo_day_s'> </a></td>
                <td align="center"><a id='lblOth_dutyfree_s'> </a></td>
                <td align="center"><a id='lblOth_tax_s'> </a></td>
                <td align="center"><a id='lblBorr_s'> </a></td>
                <td align="center" id='hid_ch_powers'><a id='lblCh_power_s'> </a></td>
                <td align="center" id='hid_chgcashs'><a id='lblChgcash_s'> </a></td>
                <td align="center" id='hid_ch_stays'><a id='lblCh_stay_s'> </a></td>
                <td align="center"><a id='lblMeal_s'> </a></td>
                <td align="center"><a id='lblTotal_s'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td ><input class="txt c1" id="txtSssno.*"type="text" /></td>
                <td ><input class="txt c1" id="txtNamea.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtBo_borns.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtBo_night.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtBo_day.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtOth_dutyfree.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtOth_tax.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtBorr.*"type="text" /></td>
                <td id='hid_ch_powers.*'><input class="txt num c1" id="txtCh_power.*"type="text" /></td>
                <td id='hid_chgcashs.*'><input class="txt num c1" id="txtChgcash.*"type="text" /></td>
                <td id='hid_ch_stays.*'><input class="txt num c1" id="txtCh_stay.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtMeal.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtTotal.*" type="text" /><input id="txtNoq.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
