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
            var q_name = "cost";
            var q_readonly = ['txtNoa'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [
            			['txtBeginmount', 15, 0, 1],['txtBeginweight', 15, 3, 1],['txtBeginmoney', 15, 0, 1],['txtBeginprice', 15, 2, 1]
            			,['txtInmount', 15, 0, 1],['txtInweight', 15, 3, 1],['txtInmoney', 15, 0, 1],['txtInprice', 15, 2, 1]
            			,['txtBornmount', 15, 0, 1],['txtBornweight', 15, 3, 1],['txtBornmoney', 15, 0, 1]
            			,['txtOutvmount', 15, 0, 1],['txtOutvweight', 15, 3, 1],['txtOutvmoney', 15, 0, 1]
            			,['txtMount', 15, 0, 1],['txtWeight', 15, 3, 1],['txtMoney', 15, 0, 1]
            			,['txtSalemount', 15, 0, 1],['txtSaleweight', 15, 3, 1],['txtSalemoney', 15, 0, 1]
            			,['txtGetmount', 15, 0, 1],['txtGetweight', 15, 3, 1],['txtGetmoney', 15, 0, 1]
            			,['txtOutsmount', 15, 0, 1],['txtOutsweight', 15, 3, 1],['txtOutsmoney', 15, 0, 1]
            			,['txtBackmount', 15, 0, 1],['txtBackweight', 15, 3, 1],['txtBackmoney', 15, 0, 1]
            			,['txtOthermount', 15, 0, 1],['txtOtherweight', 15, 3, 1],['txtOthermoney', 15, 0, 1]
            			,['txtLastmount', 15, 0, 1],['txtLastweight', 15, 3, 1],['txtLastmoney', 15, 0, 1],['txtLastprice', 15, 2, 1]
            			,['txtSampmount', 15, 0, 1],['txtSampweight', 15, 3, 1],['txtSampmoney', 15, 0, 1]
            			,['txtUccemount', 15, 0, 1],['txtUcceweight', 15, 3, 1],['txtUccemoney', 15, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 3;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Noa';
            aPop = new Array(
            	['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']
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
            var costunit='';
            function mainPost() {
				q_getFormat();
				bbmMask = [['txtMon', r_picm],['txtDatea', r_picd]];
				bbsMask = [];
				q_mask(bbmMask);
				if(q_getPara('sys.costunit').toUpperCase()=='KG')
					costunit='w';
				else
					costunit='m';
					
				$('#btnImport').click(function () {
					//取得上個月
					/*var prvmon='';
					var t_prvmon=new Date(dec($('#txtMon').val().substr(0,3))+1911,dec($('#txtMon').val().substr(4,2))-1,1);
				    t_prvmon.setDate(t_prvmon.getDate() -1)
				    prvmon=''+(t_prvmon.getFullYear()-1911)+'/';
				    //月份
				    prvmon = prvmon+(t_prvmon.getMonth()>9?(t_prvmon.getMonth()+1)+'':'0'+(t_prvmon.getMonth()+1));
				    
					var t_where = "where=^^ mon='"+prvmon+"' ^^";
                	q_gt('cost', t_where, 0, 0, 0, "pevcost", r_accy+"_"+r_cno);*/
                	
                	q_func('qtxt.query','costnextmon.txt,costnextmon,'+encodeURI(r_accy) + ';'+encodeURI($('#txtNoa').val()) + ';' + encodeURI($('#txtDatea').val()) + ';' + encodeURI(q_getPara('sys.costunit')));
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
                	case 'pevcost':
                		var as = _q_appendData("costs", "", true);
                		if(as[0]==undefined)
                			return;
                		else
                			q_gridAddRow(bbsHtm, 'tbbs', 'cmbTypea,txtProductno,txtProduct,txtBeginmount,txtBeginweight,txtBeginmoney,txtBeginprice', as.length, as, 'typea,productno,product,lastmount,lastweight,lastmoney,lastprice', '');                	
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
                
                if($('#txtDatea').val().substr(0,6)!=$('#txtMon').val()){
                	 alert('請輸入正確的'+q_getMsg('lblDatea')+'!!!');
                	 return;
                }
                
                sum();
                
                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if(s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll('GC' + q_date(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;
               q_box('cost_s.aspx', q_name + '_s', "500px", "300px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
            	for(var j = 0; j < q_bbsCount; j++) {
            		  if (!$('#btnMinus_' + j).hasClass('isAssign')) {
            		  }
                }
                
                $('#tbbs .num').change(function() {sum();});
                
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                
                $('#txtNoa').val('AUTO');
                $('#txtMon').val(q_date().substr(0,6));
                $('#txtDatea').val(q_date());
                $('#txtMon').focus();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                _btnModi();
                
            }

            function btnPrint() {
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
                 if (t_para &&!emp($('#txtNoa').val())&&!emp($('#txtMon').val())&&!emp($('#txtDatea').val())&&$('#txtDatea').val().substr(0,6)==$('#txtMon').val()){
				    $('#btnImport').removeAttr('disabled');
				}else {
				    $('#btnImport').attr('disabled', 'disabled');
				}
            }
            
            function sum() {
            	var t_gwelght=0,t_twelght = 0, t_welght = 0;
                for (var j = 0; j < q_bbsCount; j++) {
                	//數量
					if(costunit=='m'){
						if(q_float('txtBeginmount_'+j)>0)
							q_tr('txtBeginprice_'+j,round(q_float('txtBeginmoney_'+j)/q_float('txtBeginmount_'+j),2));
						else
							q_tr('txtBeginprice_'+j,0);
						if(q_float('txtInmount_'+j)>0)
							q_tr('txtInprice_'+j,round(q_float('txtInmoney_'+j)/q_float('txtInmount_'+j),2));
						else
							q_tr('txtInprice_'+j,0);
						q_tr('txtMount_'+j,q_float('txtBeginmount_'+j)+q_float('txtInmount_'+j)+q_float('txtBornmount_'+j)+q_float('txtOutvmount_'+j));
						q_tr('txtLastmount_'+j,q_float('txtMount_'+j)-q_float('txtSalemount_'+j)-q_float('txtGetmount_'+j)-q_float('txtOutsmount_'+j)+q_float('txtBackmount_'+j)+q_float('txtOthermount_'+j));
					}
					
					//重量
					if(costunit=='w'){
						if(q_float('txtBeginweight_'+j)>0)
							q_tr('txtBeginprice_'+j,round(q_float('txtBeginmoney_'+j)/q_float('txtBeginweight_'+j),2));
						else
							q_tr('txtBeginprice_'+j,0);
						if(q_float('txtInweight_'+j)>0)
							q_tr('txtInprice_'+j,round(q_float('txtInmoney_'+j)/q_float('txtInweight_'+j),2));
						else
							q_tr('txtInprice_'+j,0);
						q_tr('txtWeight_'+j,q_float('txtBeginweight_'+j)+q_float('txtInweight_'+j)+q_float('txtBornweight_'+j)+q_float('txtOutvweight_'+j));
						q_tr('txtLastweight_'+j,q_float('txtWeight_'+j)-q_float('txtSaleweight_'+j)-q_float('txtGetweight_'+j)-q_float('txtOutsweight_'+j)+q_float('txtBackweight_'+j)+q_float('txtOtherweight_'+j))
					}
					
					//金額
					q_tr('txtMoney_'+j,q_float('txtBeginmoney_'+j)+q_float('txtInmoney_'+j)+q_float('txtBornmoney_'+j)+q_float('txtOutvmoney_'+j));
					q_tr('txtLastmoney_'+j,q_float('txtMoney_'+j)-q_float('txtSalemoney_'+j)-q_float('txtGetmoney_'+j)-q_float('txtOutsmoney_'+j)+q_float('txtBackmoney_'+j)+q_float('txtOthermoney_'+j));
					
					//單價
					if(costunit=='m'){
						if(q_float('txtLastmount_'+j)>0)
							q_tr('txtLastprice_'+j,round(q_float('txtLastmoney_'+j)/q_float('txtLastmount_'+j),2));
						else
							q_tr('txtLastprice_'+j,0);
					}
					if(costunit=='w'){
						if(q_float('txtLastweight_'+j)>0)
							q_tr('txtLastprice_'+j,round(q_float('txtLastmoney_'+j)/q_float('txtLastweight_'+j),2));
						else
							q_tr('txtLastprice_'+j,0);
					}
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
            
            function q_funcPost(t_func, result) {
            	location.href = location.origin+location.pathname+"?" + r_userno + ";" + r_name + ";" + q_id + ";noa<'"+$('#txtNoa').val()+"';"+r_accy;
		        alert('結轉功能執行完畢!!');
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
            .tbbs select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size:medium;
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
         	width: 3600px;
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
         	<td class="td1"><span> </span><a id="lblDatea" class="lbl"> </a></td>
            <td class="td2"><input id="txtDatea" type="text" class="txt c1"/></td>
        	<td class="td3"><span> </span></td>
            <td class="td4"><input id="btnImport" type="button" style="float: left;"/></td>
        </tr>
        </table>
        </div>
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
                <td align="center" style="width:5%;"><a id='lblProduct_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblBeginmount_s'> </a></br> / <a id='lblBeginweight_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblBeginmoney_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblBeginprice_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblInmount_s'> </a></br> / <a id='lblInweight_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblInmoney_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblInprice_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblBornmount_s'> </a></br> / <a id='lblBornweight_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblBornmoney_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblOutvmount_s'> </a></br> / <a id='lblOutvweight_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblOutvmoney_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblMount_s'> </a></br> / <a id='lblWeight_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblMoney_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblSalemount_s'> </a></br> / <a id='lblSaleweight_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblSalemoney_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblGetmount_s'> </a></br> / <a id='lblGetweight_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblGetmoney_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblOutsmount_s'> </a></br> / <a id='lblOutsweight_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblOutsmoney_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblBackmount_s'> </a></br> / <a id='lblBackweight_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblBackmoney_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblOthermount_s'> </a></br> / <a id='lblOtherweight_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblOthermoney_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblLastmount_s'> </a></br> / <a id='lblLastweight_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblLastmoney_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblLastprice_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblSampmount_s'> </a></br> / <a id='lblSampweight_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblSampmoney_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblUccemount_s'> </a></br> / <a id='lblUcceweight_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblUccemoney_s'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td ><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
                <td >
                	<input  id="txtProductno.*" type="text" style="width:80%;" />
                	<input class="btn"  id="btnProductno.*" type="button" value='.' style=" font-weight: bold;width:1%;float:right;" />
                	<input  id="txtProduct.*" type="text" style="width:80%;"/>
                	<input id="txtNoq.*" type="hidden" />
                </td>
                <td ><input  id="txtBeginmount.*" type="text" class="txt c1 num"/>
                	<input  id="txtBeginweight.*" type="text" class="txt c1 num"/>
                </td>
                <td ><input  id="txtBeginmoney.*" type="text" class="txt c1 num"/></td>
                <td ><input  id="txtBeginprice.*" type="text" class="txt c1 num"/></td>
                <td ><input  id="txtInmount.*" type="text" class="txt c1 num"/>
                	<input  id="txtInweight.*" type="text" class="txt c1 num"/>
                </td>
                <td ><input  id="txtInmoney.*" type="text" class="txt c1 num"/></td>
                <td ><input  id="txtInprice.*" type="text" class="txt c1 num"/></td>
                <td ><input  id="txtBornmount.*" type="text" class="txt c1 num"/>
                	<input  id="txtBornweight.*" type="text" class="txt c1 num"/>
                </td>
                <td ><input  id="txtBornmoney.*" type="text" class="txt c1 num"/></td>
                <td ><input  id="txtOutvmount.*" type="text" class="txt c1 num"/>
                	<input  id="txtOutvweight.*" type="text" class="txt c1 num"/>
                </td>
                <td ><input  id="txtOutvmoney.*" type="text" class="txt c1 num"/></td>
                
                <td ><input  id="txtMount.*" type="text" class="txt c1 num"/>
                	<input  id="txtWeight.*" type="text" class="txt c1 num"/>
                </td>
                <td ><input  id="txtMoney.*" type="text" class="txt c1 num"/></td>
                <td ><input  id="txtSalemount.*" type="text" class="txt c1 num"/>
                	<input  id="txtSaleweight.*" type="text" class="txt c1 num"/>
                </td>
                <td ><input  id="txtSalemoney.*" type="text" class="txt c1 num"/></td>
                <td ><input  id="txtGetmount.*" type="text" class="txt c1 num"/>
                	<input  id="txtGetweight.*" type="text" class="txt c1 num"/>
                </td>
                <td ><input  id="txtGetmoney.*" type="text" class="txt c1 num"/></td>
                <td ><input  id="txtOutsmount.*" type="text" class="txt c1 num"/>
                	<input  id="txtOutsweight.*" type="text" class="txt c1 num"/>
                </td>
                <td ><input  id="txtOutsmoney.*" type="text" class="txt c1 num"/></td>
                <td ><input  id="txtBackmount.*" type="text" class="txt c1 num"/>
                	<input  id="txtBackweight.*" type="text" class="txt c1 num"/>
                </td>
                <td ><input  id="txtBackmoney.*" type="text" class="txt c1 num"/></td>
                <td ><input  id="txtOthermount.*" type="text" class="txt c1 num"/>
                	<input  id="txtOtherweight.*" type="text" class="txt c1 num"/>
                </td>
                <td ><input  id="txtOthermoney.*" type="text" class="txt c1 num"/></td>
                <td ><input  id="txtLastmount.*" type="text" class="txt c1 num"/>
                	<input  id="txtLastweight.*" type="text" class="txt c1 num"/>
                </td>
                <td ><input  id="txtLastmoney.*" type="text" class="txt c1 num"/></td>
                <td ><input  id="txtLastprice.*" type="text" class="txt c1 num"/></td>
                <td ><input  id="txtSampmount.*" type="text" class="txt c1 num"/>
                	<input  id="txtSampweight.*" type="text" class="txt c1 num"/>
                </td>
                <td ><input  id="txtSampmoney.*" type="text" class="txt c1 num"/></td>
                <td ><input  id="txtUccemount.*" type="text" class="txt c1 num"/>
                	<input  id="txtUcceweight.*" type="text" class="txt c1 num"/>
                </td>
                <td ><input  id="txtUccemoney.*" type="text" class="txt c1 num"/></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
