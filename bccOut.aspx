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
        var q_name = "bccout";
        var q_readonly = ['txtNoa','txtApprover'];
        var q_readonlys = [];
        var bbmNum = [];  
        var bbsNum = [['txtMount', 10, 0, 1],['txtBkbcc', 10, 0, 1]];
        var bbmMask = [];
        var bbsMask = [];
        q_desc=1;
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
        aPop = new Array(['txtSno', 'lblSname', 'sss', 'noa,namea,partno,part', 'txtSno,txtSname,txtPartno,txtPart', 'sss_b.aspx'],
        ['txtPartno','lblPart','part','noa,part','txtPartno,txtPart','part_b.aspx'],
        ['txtBccno_', 'btnBccno_', 'bcc', 'noa,product', 'txtBccno_,txtBccname_', 'bcc_b.aspx'])
		q_gt('store', '', 0, 0, 0, "");
        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();
            q_gt(q_name, q_content, q_sqlCount, 1);
            //判斷是否為權限(簽核)
            q_gt('authority', "where=^^a.noa='bccout' and a.sssno='" + r_userno + "'^^", q_sqlCount, 1);
            
        });

        //////////////////   end Ready
       function main() {
           if (dataErr) 
           {
               dataErr = false;
               return;
           }
            mainForm(1);
        }  ///  end Main()
        function mainPost() { 
            q_getFormat();
            bbmMask = [['txtDatea', r_picd]];
            bbsMask = [['txtDatea', r_picd]];
            q_mask(bbmMask);
            q_gt('store', '', 0, 0, 0, "");
            $('#txtDatea').focusout(function () {
            	q_cd( $(this).val() ,$(this));
	        });
        }

        function q_boxClose( s2) { 
            var ret; 
            switch (b_pop) {   
                case 'tgg':  
                    q_changeFill(t_name, 'txtTggno,txtComp,txtTel,txtPost,txtAddr,txtPay,cmbTrantype', 'noa,comp,tel,post_fact,addr_fact,pay,trantype');
                    break;

                case 'ucc':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtProductno_' + b_seq + ',txtProduct_' + b_seq, ret, 'noa,product');
                    break;

                case 'store':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtStoreno,txtStore', ret, 'noa,store');
                    break;

                case 'station':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtStationno,txtStation', ret, 'noa,station');
                    break;

                case 'ordes':
                    if (q_cur > 0 && q_cur < 4) {
                        b_ret = getb_ret();
                        if (!b_ret || b_ret.length == 0)
                            return;
                        var i, j = 0;
                        ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtSize,txtDime,txtWidth,txtLengthb,txtUnit,txtOrdeno,txtNo2', b_ret.length, b_ret
                                                           , 'productno,product,spec,size,dime,width,lengthb,unit,noa,no2'
                                                           , 'txtProductno,txtProduct,txtSpec');   
                        bbsAssign();

                        for (i = 0; i < ret.length; i++) {
                            k = ret[i];  
                            if (!b_ret[i]['unit'] || b_ret[i]['unit'].toUpperCase() == 'KG') {
                                $('#txtMount_' + k).val(b_ret[i]['notv']);
                                $('#txtWeight_' + k).val(divide0(b_ret[i]['weight'] * b_ret[i]['notv'], b_ret[i]['mount']));
                            }
                            else {
                                $('#txtWeight_' + k).val(b_ret[i]['notv']);
                                $('#txtMount_' + k).val(divide0(b_ret[i]['mount'] * b_ret[i]['notv'], b_ret[i]['weight']));
                            }

                        }  /// for i
                    }
                    break;
                
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
            b_pop = '';
        }

		var ischecker=false;//簽核權限
        function q_gtPost(t_name) {  
            switch (t_name) {
            	case 'authority':
		                var as = _q_appendData('authority', '', true);
		                if (as.length > 0 && as[0]["pr_dele"] == "true")
		                    ischecker = true;
		                else
		                    ischecker = false;
		                break;
                case 'ucc':  
                    q_changeFill(t_name, 'txtProductno_' + b_seq + ',txtProduct_' + b_seq + ',txtUnit_' + b_seq, 'noa,product,unit');
                    break;

                case 'store':  
					var as = _q_appendData("store", "", true);
                    var t_item = " @ ";
                        for ( i = 0; i < as.length; i++) {
                            t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].store;
                        }
                        q_cmbParse("cmbStoreno", t_item,'s');
                    //q_changeFill(t_name, 'txtStoreno,txtStore', 'noa,store');
                    break;

                case 'station':  
                    q_changeFill(t_name, 'txtStationno,txtStation', 'noa,station');
                    break;

                case q_name: if (q_cur == 4)   
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }
      

        function btnOk() {
            $('#txtDatea').val($.trim($('#txtDatea').val()));
                if (checkId($('#txtDatea').val())==0){
                	alert(q_getMsg('lblDatea')+'錯誤。');
                	return;
            }            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  // ??d??? 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }

            $('#txtWorker').val(r_name)
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   /// ??????s??
                q_gtnoa(q_name, replaceAll('A' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('bccout_s.aspx', q_name + '_s', "500px", "340px", q_getMsg("popSeek"));
        }


        function bbsAssign() {
        	for(var j = 0; j < q_bbsCount; j++) {
        		$('#lblNo_'+j).text(j+1);	
            	if (!$('#btnMinus_' + j).hasClass('isAssign')) {
            		/*$('#txtMount_' + j).change(function () {
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						
						if(q_cur==1&&!emp($('#txtMount_'+b_seq).val())&&!emp($('#txtStkmount_'+b_seq).val())&&dec($('#txtMount_'+b_seq).val())>dec($('#txtStkmount_'+b_seq).val())){
							alert('庫存不足');
							$('#txtMount_'+b_seq).val('0');
							return;
						}
				    });*/
				}
				
			}
            _bbsAssign();
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtDatea').val(q_date());
            $('#txtDatea').focus();
            if(ischecker){
            	$('#lblApprover').click(function (e) {
		             $('#txtApprover').val(r_name);
		     	});
            }
         }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtProduct').focus();
            if(ischecker){
            	$('#lblApprover').click(function (e) {
		             $('#txtApprover').val(r_name);
		     	});
            }
        }
        function btnPrint() {
 			q_box('z_bcc.aspx', '', "95%", "650px", q_getMsg("popPrint"));
        }

        function wrServer( key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0],bbsKey[1],'',2);
        }

        function bbsSave(as) {   
            if (!as['bccno'] && !as['bccname'] ) {  
                as[bbsKey[1]] = '';   
                return;
            }

            q_nowf();
            as['datea'] = abbm2['datea'];
            as['sno'] = abbm2['sno'];
            as['sname'] = abbm2['sname'];
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
            var t1 = 0, t_unit, t_mount, t_weight = 0,t_total=0;
            for (var j = 0; j < q_bbsCount; j++) {
				
            }  // j
        }
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

        function btnSeek(){
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
                width: 23%;
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
                width: 75%;
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
            .tbbs input[type="text"] {
                width: 95%;
            }
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs{
            	float:left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
       
      
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' >
        <div class="dview" id="dview" style="float: left;  width:25%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:20%"><a id='vewDatea'></a></td>
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='noa'>~noa</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 74%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='1'  cellspacing='0'>
        <tr>
               <td class="td1"><span> </span><a id='lblDatea' class="lbl"></a></td>
               <td class="td2"><input id="txtDatea"  type="text" /></td>
               <td class="td3"><span> </span><a id='lblNoa' class="lbl"></a></td>
               <td class="td4"><input id="txtNoa" type="text"  /></td>
               <td class="td5"></td>
               <td class="td6"></td>               
        </tr>
        <tr>
            <td class="td1"><span> </span><a id='lblSname' class="lbl btn"></a></td>
            <td class="td2"><input id="txtSno"  type="text" class="txt c2"/><input id="txtSname"  type="text" class="txt c3"/></td> 
            <td class="td3"><span> </span><a id="lblPart" class="lbl btn"></a></td>               
            <td class="td4"><input id="txtPartno"  type="text" class="txt c2" /><input id="txtPart"  type="text"  class="txt c3"/></td>
            <!--<td class="td5"><span> </span><a id='lblTotal' class="lbl"></a></td>
            <td class="td6"><input id="txtTotal"  type="text" class="txt num c1"/></td>-->
            <td class="td5"><span> </span><a id='lblApprover' class="lbl btn"></a></td>
            <td class="td6"><input id="txtApprover"  type="text"  class="txt c1"/></td> 
        </tr>  
        <tr>
            <td class="td1"><span> </span><a id="lblMemo" class="lbl"></a></td>
            <td class="td2" colspan="7"><input id="txtMemo"  type="text"  class="txt c1"/></td>
        </tr>       
        </table>
        </div>
		</div>
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'>
            <tr style='color:white; background:#003366;' >
            	<td  align="center" style="width:30px;">
                	<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
				</td>
				<td align="center" style="width:20px;"> </td>
                <td align="center" style="width:10%;"><a id='lblDateas'></a></td>
                <td align="center" style="width:10%;"><a id='lblStoreno'></a></td>
                <td align="center" style="width:10%;"><a id='lblBccno'></a></td>
                <td align="center" style="width:18%;"><a id='lblBccname'></a></td>
                <td align="center" style="width:10%;"><a id='lblMount'></a></td>
                <td align="center" style="width:10%;"><a id='lblBkbcc'></a></td>
                <td align="center"><a id='lblMemos'></a></td>
                <td align="center"  style="width:18%;"><a id='lblUno'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'> 
                <td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
				</td>
				<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                <td ><input class="txt c1" id="txtDatea.*"type="text" /></td>
                <td ><select id="cmbStoreno.*" class="txt c1"></td>
                <td ><input id="txtBccno.*" type="text" style="width: 70%;"/><input id="btnBccno.*" type="button" value="." style="width: auto;font-size: medium;" /></td>
                <td ><input class="txt c1" id="txtBccname.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtMount.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtBkbcc.*" type="text" /></td>
                <td ><input class="txt c1" id="txtMemo.*" type="text" /></td>
                <td ><input class="txt c1" id="txtUno.*" type="text" /></td>
           </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
