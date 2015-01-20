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
        var decbbm = [];
        var q_name = "invo";
        var q_readonly = ['txtNoa','txtVccno'];
        var bbmNum = []; 
        var bbmMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'noa';
		aPop = new Array(['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']);
        $(document).ready(function () {
            bbmKey = ['noa'];
            q_brwCount();
            q_gt(q_name, q_content, q_sqlCount, 1)
        });

        //////////////////   end Ready
        function main() {
            if (dataErr) {
                dataErr = false;
                return;
            }
            mainForm(0); // 1=Last  0=Top
        }  ///  end Main()


        function mainPost() {
			q_getFormat();
			var bbmMask = [['txtDatea',r_picd],['txtDate_customs',r_picd],['txtEtd',r_picd],
						   ['txtEta',r_picd],['txtShipmentdate',r_picd],['txtSaildate',r_picd],
						   ['txtAdvancesdate',r_picd],['txtLcdate',r_picd],['txtDodate',r_picd],
						   ['txtPaydate',r_picd],['txtRedeemdate',r_picd]
						  ];
			q_mask(bbmMask);
		} 

        function q_boxClose(s2) { ///   q_boxClose 2/4 
            var ret;
            switch (b_pop) {   
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
        }


        function q_gtPost(t_name) { 
            switch (t_name) {
               case q_name: if (q_cur == 4)   
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;
		}

        function btnIns() {
        	return;
            /*_btnIns();
            $('#txtNoa').focus();
            */
        }

        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;

            _btnModi(1);
        }

        function btnPrint() {

        }
        function btnOk() {
            var t_err = '';

            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtComp', q_getMsg('lblComp')]]);

            if (t_err.length > 0) {
                alert(t_err);
                return;
            }
            var t_noa = trim($('#txtNoa').val());

            if (t_noa.length == 0)   
                q_gtnoa(q_name, t_noa);
            else
                wrServer(t_noa);
        }

        function wrServer(key_value) {
            var i;

            xmlSql = '';
            if (q_cur == 2)   /// popSave
                xmlSql = q_preXml();

            $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], '', '', 2);
        }

        function refresh(recno) {
            _refresh(recno);
        }

        function readonly(t_para, empty) {
            _readonly(t_para, empty);
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
            _btnDele();
        }

        function btnCancel() {
            _btnCancel();
        }
    </script>
    <style type="text/css">
        #dmain{overflow:hidden;}
		 .dview{float:left;width:25%;}
		 .tview{margin:0;padding:2px;border:1px black double;border-spacing:0;font-size:16px;background-color:#FFFF66;color:blue;}
		 .tview td{padding:2px;text-align:center;border:1px black solid;}
		 .dbbm{float:left;width:73%;margin:-1px;border:1px black solid;border-radius:5px;}
		 .tbbm{padding:0px;border:1px white double;border-spacing:0;border-collapse:collapse;font-size:16px;color:blue;background:#cad3ff;width:100%;}
		 .tbbm tr{height:35px;}
		 
		 .td1, .td3, .td5, .td7, .td9{width: 10%; text-align: right;}
		 .td2, .td4, .td6, .td8, .tdA{width: 10%;}
		 .tbbm tr td span{float:right;display:block;width:8px;height:10px;}
		 .tbbm tr td .lbl{float:right;color:blue;font-size:16px;}
		 .tbbm tr td .lbl.btn{color:#4297D7;font-weight:bolder;}
		 .tbbm tr td .lbl.btn:hover{color:#FF8F19;}
		 .tbbm tr td .txt.c1{width:98%;float:left;}
		 .tbbm tr td .txt.c2{width:99%;float:left;}
		 .tbbm tr td .txt.c3{width:95%;float:left;}
		 .tbbm tr td .txt.c4{width:53%;float:left;}
		 .tbbm tr td .txt.c5{width:32%;float:left;}
		 .txt.c6{width:64%;float:left;}
		 .tbbm tr td .txt.num{text-align:right;}
		 .txt.c7{width:96%;text-align: right;}
		 .txt.c8{width:98%;}
		
		 .dbbs .tbbs{margin:0;padding:2px;border:2px lightgrey double;border-spacing:1px;border-collapse:collapse;font-size:16px;color:blue;background:#cad3ff;width:100%;}
		 .dbbs .tbbs tr{height:35px;}
		 .dbbs .tbbs tr td{text-align:center;border:2px lightgrey double;}
		
		 input[type="text"], input[type="button"]{font-size: medium;}
		 .tbbm tr td{margin:0px -1px;padding:0;}
		 .tbbm tr td input[type="text"]{border-width:1px;padding:0px;margin:-1px;}
		 .tbbm tr td select{border-width:1px;padding:0px;margin:-1px;width: 98%;}
      	 .tbbs .td1{width: 4%;}
      	 .tbbs .td2{width: 6%;}
      	 .tbbs .td3{width: 8%;}
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="overflow:hidden;">
        <div class="dview" id="dview" style="float: left;  width:25%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
                <td align="center" style="width:40%"><a id='vewOrdeno'></a></td>
            </tr>
             <tr>
                <td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
                <td align="center" id='noa'>~noa</td>
                <td align="center" id='ordeno'>~ordeno</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 73%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
        <tr class="tr1">
            <td class="td1" ><span> </span><a id='lblNoa'></a></td>
            <td class="td2"><input id="txtNoa"  type="text"  class="txt c1"/></td>
            <td class="td3"><span> </span><a id="lblOrdeno" style="font-size: 14px;"></a></td>
            <td class="td4"><input id="txtOrdeno" type="text" class="txt c1" /></td>
            <td class="td5"><span> </span><a id="lblVccno" style="font-size: 14px;"></a></td>
            <td class="td6"><input id="txtVccno" type="text" class="txt c1" /></td>
            <td class="td7"><span> </span><a id="lblDatea"></a></td>
            <td class="td8"><input id="txtDatea" type="text" class="txt c1" /></td>
            <td class="td9"><span> </span><a id="lblDate_customs"></a></td>
            <td class="tdA"><input id="txtDate_customs" type="text" class="txt c3" /></td>
       </tr>
	   <tr class="tr2">
		<td class="td1"><span> </span><a id='lblShipped'></a></td>
        <td class="td2" colspan="5"><input id="txtShipped"  type="text" class="txt c2" /></td>
        <td class="td7"><span> </span><a id='lblUnit'></a></td>
        <td class="td8"><input id="txtUnit"  type="text" class="txt c1" /></td>
	   </tr>  
	   <tr class="tr3">
		 <td class="td1"><span> </span><a id='lblCommodity'></a></td>
         <td class="td2" colspan="5"><input id="txtCommodity"  type="text" class="txt c2" /></td>
         <td class="td7"><span> </span><a id='lblContract'></a></td>
         <td class="td8"><input id="txtContract"  type="text" class="txt c1" /></td>
	   </tr>
	   <tr class="tr4">
            <td class="td1" ><span> </span><a id='lblFroma'></a></td>
            <td class="td2" colspan="2"><input id="txtFroma"  type="text"  class="txt c1"/></td>
            <td class="td4"></td>
            <td class="td5"><span> </span><a id="lblToa"></a></td>
            <td class="td6" colspan="2"><input id="txtToa" type="text" class="txt c1" /></td>
            <td class="td8"></td>
            <td class="td9"><span> </span><a id="lblLcno"></a></td>
            <td class="tdA"><input id="txtLcno" type="text" class="txt c3" /></td>
       </tr>
       <tr class="tr5">
            <td class="td1" ><span> </span><a id='lblEtd'></a></td>
            <td class="td2" colspan="2"><input id="txtEtd"  type="text"  class="txt c1"/></td>
            <td class="td4"></td>
            <td class="td5"><span> </span><a id="lblEta"></a></td>
            <td class="td6" colspan="2"><input id="txtEta" type="text" class="txt c1" /></td>
            <td class="td8"></td>
            <td class="td9"><span> </span><a id="lblPacking"></a></td>
            <td class="tdA"><input id="txtPacking" type="text" class="txt c3" /></td>
       </tr>                               
       <tr class="tr6">
		 <td class="td1"><span> </span><a id='lblMessrsm'></a></td>
         <td class="td2" colspan="9"><textarea id="txtMessrsm" cols="10" rows="5" style="width: 98%;height: 50px;"></textarea></td>
	   </tr>
	   <tr class="tr7">
		 <td class="td1"><span> </span><a id='lblInvo'></a></td>
         <td class="td2" colspan="9"><textarea id="txtMemotitle" cols="10" rows="5" style="width: 98%;height: 50px;"></textarea></td>
	   </tr>    
	   <tr class="tr8">
		 <td class="td1"><span> </span><a id='lblInvom'></a></td>
         <td class="td2" colspan="9"><textarea id="txtMemobottom" cols="10" rows="5" style="width: 98%;height: 50px;"></textarea></td>
	   </tr>
	   <tr class="tr9">
            <td class="td1" ><span> </span><a id='lblLcbauk'></a></td>
            <td class="td2"><input id="txtLcbauk"  type="text"  class="txt c1"/></td>
            <td class="td3"><span> </span><a id="lblShipmentdate"></a></td>
            <td class="td4"><input id="txtShipmentdate" type="text" class="txt c1" /></td>
            <td class="td5"><span> </span><a id="lblSaildate"></a></td>
            <td class="td6"><input id="txtSaildate" type="text" class="txt c1" /></td>
            <td class="td7"><span> </span><a id="lblAdvancesdate"></a></td>
            <td class="td8"><input id="txtAdvancesdate" type="text" class="txt c1" /></td>
            <td class="td9"><span> </span><a id="lblTgg" class="lbl btn"></a></td>
            <td class="tdA"><input id="txtTggno" type="text" class="txt c5" /><input id="txtTgg" type="text" class="txt c6" /></td>
       </tr>
       <tr class="tr10">
            <td class="td1" ><span> </span><a id='lblLcdate'></a></td>
            <td class="td2"><input id="txtLcdate"  type="text"  class="txt c1"/></td>
            <td class="td3"><span> </span><a id="lblDodate"></a></td>
            <td class="td4"><input id="txtDodate" type="text" class="txt c1" /></td>
            <td class="td5"><span> </span><a id="lblPaydate"></a></td>
            <td class="td6"><input id="txtPaydate" type="text" class="txt c1" /></td>
            <td class="td7"><span> </span><a id="lblRedeemdate"></a></td>
            <td class="td8"><input id="txtRedeemdate" type="text" class="txt c1" /></td>
       </tr>        
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
