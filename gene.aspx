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
			q_desc=1;
            q_tables = 's';
            var q_name = "gene";
            var q_readonly = ['txtNoa'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['txtBornmount', 15, 0, 1],['txtBornweight', 15, 2, 1],['txtStuffmount', 15, 0, 1],['txtStuffweight', 15, 2, 1],['txtStuffmoney', 15, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 3;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Noa';
            aPop = new Array(
            	['txtProductno_', 'btnProductno_', 'ucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_,txtAcc1_', 'ucc_b.aspx'],
            	['txtAcc1_', 'btnAcc1_', 'acc', 'acc1,acc2', 'txtAcc1_,txtAcc2_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy+ '_' + r_cno],
            	['txtAcc3_', 'btnAcc3_', 'acc', 'acc1,acc2', 'txtAcc3_,txtAcc4_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy+ '_' + r_cno],
            	['txtStuffno_', 'btnStuffno_', 'ucc', 'noa,product', 'txtStuffno_,txtStuffname_', 'ucc_b.aspx']
			);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
            });
            //////////////////   end Ready
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(1);
            }
            function mainPost() {
				q_getFormat();
				bbmMask = [['txtMon', r_picm]];
				bbsMask = [];
				q_mask(bbmMask);
				
				$('#btnImport').click(function () {
					if(emp($('#txtMon').val())){
						alert('請先輸入'+q_getMsg('lblMon'));
						return;
					}
					var t_where = "where=^^ left(a.datea,6)= '"+$('#txtMon').val()+"' and c.productno!='' group by a.productno,a.product,a.unit,c.productno,c.product order by a.productno^^";
			        q_gt('gene_import', t_where, 0, 0, 0, "", r_accy);
				});
            }
		
            function q_boxClose(s2) {///   q_boxClose 2/4
				var	ret;
				b_ret = getb_ret();
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'gene_import':
                		var as = _q_appendData("workbs", "", true);
                			if(as[0]==undefined)
                				return;
                			for (var i = 0; i < as.length; i++) {
                				//會計科目處理
                				as[i].acc1='1136.'+as[i].wbproductno;
                				as[i].acc2='製成品-'+as[i].wbproduct;
                				as[i].acc3='1137.'+as[i].waproductno;
                				as[i].acc4='原料-'+as[i].waproduct;
                			}
                			q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtAcc1,txtAcc2,txtBornmount,txtBornweight,txtUnit,txtStuffno,txtStuffname,txtAcc3,txtAcc4,txtStuffmount,txtStuffweight,txtStuffmoney', as.length, as, 'wbproductno,wbproduct,acc1,acc2,wbmount,wbweight,unit,waproductno,waproduct,acc3,acc4,wamount,waweight,rctotal', '');
                		break;
                    case q_name:
                        if(q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function btnOk() {
            	t_err = '';
                t_err = q_chkEmpField([['txtMon', q_getMsg('lblMon')]]);
                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if(s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_gene') + q_date(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;
               q_box('gene_s.aspx', q_name + '_s', "500px", "300px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
            	for(var j = 0; j < q_bbsCount; j++) {
            		  if (!$('#btnMinus_' + j).hasClass('isAssign')) {
            		  }
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                
                $('#txtNoa').val('AUTO');
                $('#txtMon').val(q_date().substr(0,6));
                $('#txtMon').focus();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                _btnModi();
                
            }

            function btnPrint() {
            	q_box('z_genep.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['productno']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                as['mon'] = abbm2['mon'];
                return true;
            }


            function refresh(recno) {
                _refresh(recno);
                
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
              if (t_para) {
					$('#btnImport').attr('disabled', 'disabled');
                } else {
                	$('#btnImport').removeAttr('disabled');
                }
            }
            
            function sum() {
            	var t_gwelght=0,t_twelght = 0, t_welght = 0;
                for (var j = 0; j < q_bbsCount; j++) {
					
                } // j
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
            .txt.c6 {
                width: 50%;
                float: left;
            }
            .txt.c7 {
            	float:left;
                width: 22%;
                
            }
            .txt.c8 {
            	float:left;
                width: 65px;
                
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
                font-size:medium;
            }
            .tbbm textarea {
            	font-size: medium;
            }
            
             input[type="text"],input[type="button"] {     
                font-size: medium;
            }
         .dbbs .tbbs{
         	margin:0;
         	padding:2px;
         	border:2px lightgrey double;
         	border-spacing:1px;
         	border-collapse:collapse;
         	font-size:medium;
         	color:blue;
         	background:#cad3ff;
         	width: 100%;
         }
		 .dbbs .tbbs tr{
		 	height:35px;
		 }
		 .dbbs .tbbs tr td{
		 	text-align:center;
		 	border:2px lightgrey double;
		 }
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                <td align="center" style="width:20%"><a id='vewNoa'> </a></td>
                <td align="center" style="width:25%"><a id='vewMon'> </a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='mon'>~mon</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr class="tr1">
        	<td class="td1"><span> </span><a id="lblNoa" class="lbl"> </a></td>
            <td class="td2"><input id="txtNoa" type="text" class="txt c1"/></td>
            <td class="td3"><span> </span><a id="lblMon" class="lbl"> </a></td>
            <td class="td4"><input id="txtMon" type="text" class="txt c1"/></td>
        </tr>
        <tr class="tr1">
        	<td class="td3"><span> </span></td>
            <td class="td4"><input id="btnImport" type="button" style="float: left;"/></td>
        </tr>
        </table>
        </div>
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
                <td align="center" style="width:14%;"><a id="lblProduct_s" > </a></td>
                <td align="center" style="width:14%;"><a id='lblAcc1_s'> </a></td>
                <td align="center" style="width:7%;"><a id='lblBornmount_s'> </a></br> / <a id='lblBornweight_s'> </a></td>
                <td align="center" style="width:4%;"><a id='lblUnit_s'> </a></td>
                <td align="center" style="width:14%;"><a id='lblStuffno_s'> </a></td>
                <td align="center" style="width:14%;"><a id='lblAcc3_s'> </a></td>
                <td align="center" style="width:7%;"><a id='lblStuffmount_s'> </a></br> / <a id='lblStuffweight_s'> </a></td>
                <td align="center" style="width:7%;"><a id='lblStuffmoney_s'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td ><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
                <td >
                	<input  id="txtProductno.*" type="text" style="width:80%;" />
                	<input class="btn"  id="btnProductno.*" type="button" value='.' style=" font-weight: bold;width:1%;float:right;" />
                	<input  id="txtProduct.*" type="text" style="width:80%;"/>
                	<input id="txtNoq.*" type="hidden" />
                </td>
                <td >
                	<input  id="txtAcc1.*" type="text" style="width:80%;" />
                	<input class="btn"  id="btnAcc1.*" type="button" value='.' style=" font-weight: bold;width:1%;float:right;" />
                	<input  id="txtAcc2.*" type="text" style="width:80%;"/>
                </td>
                <td ><input  id="txtBornmount.*" type="text" class="txt c1 num"/>
                	 <input  id="txtBornweight.*" type="text" class="txt c1 num"/>
                </td>
                <td ><input  id="txtUnit.*" type="text" class="txt c1"/></td>
                <td >
                	<input  id="txtStuffno.*" type="text" style="width:80%;" />
                	<input class="btn"  id="btnStuffno.*" type="button" value='.' style=" font-weight: bold;width:1%;float:right;" />
                	<input  id="txtStuffname.*" type="text" style="width:80%;"/>
                </td>
                <td >
                	<input  id="txtAcc3.*" type="text" style="width:80%;" />
                	<input class="btn"  id="btnAcc3.*" type="button" value='.' style=" font-weight: bold;width:1%;float:right;" />
                	<input  id="txtAcc4.*" type="text" style="width:80%;"/>
                </td>
                <td ><input  id="txtStuffmount.*" type="text" class="txt c1 num"/>
                	 <input  id="txtStuffweight.*" type="text" class="txt c1 num"/>
                </td>
                <td ><input  id="txtStuffmoney.*" type="text" class="txt c1 num"/></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
