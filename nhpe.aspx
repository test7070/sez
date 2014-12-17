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
        var decbbm = ['rank', 'credit'];
        var q_name = "nhpe";
        var q_readonly = [];
        var bbmNum = [];
        var bbmMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'noa';
        //ajaxPath = ""; //  execute in Root
        aPop = new Array(['txtPartno', 'lblPartno', 'part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx']
        ,['txtNoa', '', 'sss', 'noa,namea,id', 'txtNoa,txtNamea,textPassword', 'sss_b.aspx']);
        $(document).ready(function () {
            bbmKey = ['noa'];
            //brwCoubt2 = 35
            q_brwCount();
			$('#CopyTr').hide();
            if (r_rank < 8) {
                q_content = "where=^^noa='" + r_userno + "'^^";
            }
            q_gt(q_name, q_content, q_sqlCount, 1)
        });

        //////////////////   end Ready
        function main() {
            if (dataErr) {
                dataErr = false;
                return;
            }
            q_mask(bbmMask);
            mainForm(0); // 1=Last  0=Top
            $('#txtNoa').focus();
        }  ///  end Main()

		var t_copyStatus=false;
        function mainPost() {
        	var t_where='';
        	if (r_rank < 8) {
                t_where = "where=^^noa='" + r_userno + "'^^";
            }
            if(r_rank < 8){
            	$('#CopyTr').hide();
            	$('#btnCopy').remove();
            }else{
            	$('#CopyTr').show();
				q_gt('nhpe', t_where, 0, 0, 0, 'nhpe_sss');
			}
            
            $('#btnPassword').click(function () {
			    if (r_rank < $('#txtRank').val()) {
			        alert(mess_auth1[r_lang]);
			        return;
			    }
			    $('#textPassword').val( $('#txtPasswd').val());

			});
			$('#btnCopy').click(function () {
			    if (r_rank >= 8) {
			        t_noa = $.trim($('#txtNoa').val());
			        t_copynoa = $.trim($('#combCopy').val());
			        if (q_cur != 2 && !emp(t_noa) && !emp(t_copynoa)) {
			            t_copyStatus = true;
			            q_func('qtxt.query', 'authorityCopy.txt,authorityCopy,' + encodeURI(t_noa) + ';' + encodeURI(t_copynoa));
			        }
			    }
			});
			
			$('#btnAuthoritys').click(function () {
				var t_sssno = $.trim($('#txtNoa').val());
				q_box("authority_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";sssno='" + t_sssno + "';" + r_accy + ";" + q_cur, 'authority_b', "800px", "750px",$('#btnAuthoritys').val());
			});
        }
		function q_funcPost(t_func, result) {
			if(t_copyStatus==true){
				alert('權限複製完畢!!');
		        t_copyStatus=false;
			}
		} //endfunction

        function q_boxClose(s2) {
            var ret;
            switch (b_pop) {
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
        }

        function q_gtPost(t_name) {
            switch (t_name) {
                case 'nhpe_sss': 
					var as = _q_appendData("nhpe", "", true);
						if (as[0] != undefined) {
							var t_item = "@";
							for (i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' ' + as[i].namea;
							}
							q_cmbParse("combCopy", t_item);
							refresh(q_recno);
						}
						break;
				case q_name:
                	if (q_cur == 4)
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;
            q_box('nhpe_s.aspx', q_name + '_s', "500px", "350px", q_getMsg("popSeek"));
        }

        function btnIns() {
            _btnIns();
            $('#txtNoa').focus();
        }

        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            
            if (r_rank < $('#txtRank').val()) {
                alert(mess_auth1[r_lang]);
                return;
            }

            _btnModi(1);
            $('#txtNamea').focus();

            $('#textPassword').val($('#txtPasswd').val());
        }

        function btnPrint() {

        }
        function btnOk() {
            var t_err = '';

            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
			/*
            if (dec($('#txtCredit').val()) > 9999999999)
                t_err = t_err + q_getMsg('msgCreditErr ') + '\r';
			*/
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }

            $('#txtPasswd').val( $('#textPassword').val());
            var t_noa = trim($('#txtNoa').val());
            if (t_noa.length == 0)
                q_gtnoa(q_name, t_noa);
            else
                wrServer(t_noa);
        }

        function wrServer(key_value) {
            var i;

            xmlSql = '';
            if (q_cur == 2)
                xmlSql = q_preXml();

            $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], '', '', 2);
        }

        function refresh(recno) {
            _refresh(recno);
        }

        function readonly(t_para, empty) {
            if (r_rank < 8)
                q_readonly = ['txtPartno', 'txtPart', 'txtQ_id', 'txtRank', 'txtCredit', 'combCopy'];
            _readonly(t_para, empty);

            if (r_rank < 8) {
                $('#btnCopy').attr('disabled', 'disabled');
                $('#combCopy').attr('disabled', 'disabled');
                $('#btnAdd').attr('disabled', 'disabled');
                $('#btnIns').attr('disabled', 'disabled');
                $('#btnDele').attr('disabled', 'disabled');
            }
            if(!t_para){
                $('#btnCopy').attr('disabled', 'disabled');
                $('#combCopy').attr('disabled', 'disabled');
                $('#btnPassword').attr('disabled', 'disabled');
			}else if(t_para && r_rank >=8){
                $('#btnCopy').removeAttr('disabled');
                $('#combCopy').removeAttr('disabled');
                $('#btnPassword').removeAttr('disabled');
            }
        }

        function btnMinus(id) {
            _btnMinus(id);
        }

        function btnPlus(org_htm, dest_tag, afield) {
            _btnPlus(org_htm, dest_tag, afield);
            if (q_tables == 's')
                bbsAssign();
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
            if (r_rank < $('#txtRank').val()) {
                alert(mess_auth1[r_lang]);
                return;
            }

            _btnDele();
        }

        function btnCancel() {
            _btnCancel();
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
                width: 36%;
                float: right;
            }
            .txt.c3 {
                width: 62%;
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
                float: left;
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
            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .tbbm select{
            	font-size:medium;
            }
      
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="overflow:hidden;">
        <div class="dview" id="dview" style="float: left;  width:30%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                <td align="center" style="width:25%"><a id='vewNoa'> </a></td>
                <td align="center" style="width:25%"><a id='vewNamea'> </a></td>
                <td align="center" style="width:25%"><a id='vewPart'> </a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='namea'>~namea</td>
                   <td align="center" id='part'>~part</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 65%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
            <tr>
               <td class="td1"><span> </span><a id='lblNoa' class="lbl"> </a></td>
               <td class="td2"><input id="txtNoa"  type="text"  class="txt c1"/></td>
               <td class="td3"> </td>
               <td class="td4"> </td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblNamea' class="lbl"> </a></td>
               <td class="td2"><input id="txtNamea"  type="text"  class="txt c1"/></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblPasswd' class="lbl"> </a></td>
               <td class="td2"><input id="textPassword"  type="text" class="txt c1"/><input id="txtPasswd" maxlength="20" type="hidden" class="txt c1"/></td>
               <td> <input id="btnPassword" type="button" style="width: auto;font-size: medium;" /></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblRank' class="lbl"> </a></td>
               <td class="td2"><input id="txtRank"  type="text"  class="txt num c1" /></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblPartno' class="lbl btn"> </a></td>
               <td class="td2"colspan="2"><input id="txtPartno"  type="text"  class="txt c2" />
               	<input id="txtPart"  type="text"  class="txt c3" />
               </td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblQ_id' class="lbl"> </a></td>
               <td class="td2"><input id="txtQ_id" type="text" class="txt c1"/></td>
            </tr>   
            <tr>
               <td class="td1"><span> </span><a id='lblCredit' class="lbl"> </a></td>
               <td class="td2"><input id="txtCredit"  type="text"  class="txt num c1"/></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblOuts' class="lbl"> </a></td>
               <td class="td2"><input id="chkOuts"  type="checkbox"/></td>
            </tr>
            <tr id="CopyTr">
               <td class="td1"><span> </span><a id='lblCopy' class="lbl"> </a> </td>
               <td class="td2"><select id="combCopy" class="txt c1"> </select></td>
               <td class="td3"><input id="btnCopy" type="button" style="width: auto;font-size: medium;" /></td>
               <td class="td4"><input id="btnAuthoritys" type="button" style="width: auto;font-size: medium;" /></td>
            </tr>
            <!--
            <tr>
               <td class="td1"><span> </span><a id='lblAdd' class="lbl"> </a> </td>
               <td class="td2"><input id="textAdd" type="text" class="txt c1"/></td>
               <td class="td3"><input id="btnAdd" type="button" style="width: auto;font-size: medium;" /></td>
            </tr>
            -->
        </table>
        </div>
        </div>
         <input id="q_sys" type="hidden" />    
</body>
</html>
            




