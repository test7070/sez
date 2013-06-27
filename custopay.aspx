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
        var q_name="custopay";
        var q_readonly = ['txtNoa','txtAccno','txtBummno','txtEummno','txtWorker','txtWorker2'];
        var bbmNum = [['txtMoney', 10, 0, 1]];
        var bbmMask = [];
        q_sqlCount = 6;
        brwCount = 6;
        brwList =[] ;
        brwNowPage = 0 ;
        brwKey = 'noa';
        //ajaxPath = ""; //  execute in Root
        aPop = new Array(
						['txtCustfromno', 'lblCustfrom', 'cust', 'noa,comp', 'txtCustfromno,txtCustfrom', 'cust_b.aspx'],
						['txtCusttono', 'lblCustto', 'cust', 'noa,comp', 'txtCusttono,txtCustto', 'cust_b.aspx'],
						['txtPartfromno', 'lblPartfromno', 'part', 'noa,part', 'txtPartfromno,txtPartfrom', 'part_b.aspx'],
						['txtParttono', 'lblParttono', 'part', 'noa,part', 'txtParttono,txtPartto', 'part_b.aspx']
        				);
        $(document).ready(function () {
            bbmKey = ['noa'];
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
            mainForm(0); // 1=Last  0=Top
        }  ///  end Main()


        function mainPost() { 
			q_getFormat();
        	 bbmMask = [['txtDatea', r_picd]];
            q_mask(bbmMask);
            $('#lblAccno').click(function() {
            	if($('#txtDatea').val().substring(0,3).length>0)
                q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0,3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "95%", "95%", q_getMsg('popAccc'), true);
            });
            $('#lblUmmfromto').click(function() {
			    t_bummno = trim($('#txtBummno').val());
			    t_eummno = trim($('#txtEummno').val());
        		var t_where = " noa between '" + t_bummno + "' and '" + t_eummno + "'";
        		q_box("ummtran.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";"+ t_where +";" + r_accy + '_' + r_cno, 'umm', "95%", "95%", q_getMsg("popUmm"));
            });
        }
        function q_boxClose( s2) {
            var ret; 
            switch (b_pop) {
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
        }


        function q_gtPost(t_name) {  
            switch (t_name) {
                 case q_name: 
                 	if (q_cur == 4)  
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }
        
        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;
        }

        function btnIns() {
            _btnIns();
            $('#txtNoa').val('AUTO');
            $('#txtDatea').val(q_date());
            $('#txtDatea').focus();
            
        }

        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtDatea').focus();
        }

        function btnPrint() {
        }
        function btnOk() {
             var t_err = '';
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
            if( t_err.length > 0) {
                alert(t_err);
                return;
            }
			if(q_cur==1)
	           	$('#txtWorker').val(r_name);
	        else
	           	$('#txtWorker2').val(r_name);
			var t_noa = trim($('#txtNoa').val());
			var t_date = trim($('#txtDatea').val());
    		if (t_noa.length == 0 || t_noa == "AUTO")
		    	q_gtnoa(q_name, replaceAll('A' + (t_date.length == 0 ? q_date() : t_date), '/', ''));
		    else
		        wrServer(t_noa);
        }

        function wrServer( key_value) {
            var i;
            xmlSql = '';
            if (q_cur == 2)   /// popSave
                xmlSql = q_preXml();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], '','',2);
        }
        
        function q_stPost() {
	        if (!(q_cur == 1 || q_cur == 2))
	        	return false;
	        abbm[q_recno]['accno'] = xmlString.split(";")[0];
	        abbm[q_recno]['bummno'] = xmlString.split(";")[1];
	        abbm[q_recno]['eummno'] = xmlString.split(";")[2];
	        $('#txtAccno').val(xmlString.split(";")[0]);
	        $('#txtBummno').val(xmlString.split(";")[1]);
	        $('#txtEummno').val(xmlString.split(";")[2]);
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
    </script>
    <style type="text/css">
        #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 38%;
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
                width: 58%;
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
            
             input[type="text"],input[type="button"] {     
                font-size: medium;
            }
    </style>
</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="overflow:hidden;">
	        <div class="dview" id="dview" style="float: left;  width:30%;"  >
	           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
	            <tr>
	                <td align="center" style="width:5%"><a id='vewChk'></a></td>
	                <td align="center" style="width:20%"><a id='vewDatea'></a></td>
	                <td align="center" style="width:30%"><a id='vewCustfrom'></a></td>
	                <td align="center" style="width:30%"><a id='vewCustto'></a></td>
	            </tr>
	             <tr>
	                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
	                   <td align="center" id='datea'>~datea</td>
	                   <td align="center" id='custfrom'>~custfrom</td>
	                   <td align="center" id='custto'>~custto</td>
	            </tr>
	        </table>
	        </div>
	        <div class='dbbm' style="width: 68%;float: left;">
		        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCustfrom" class="lbl btn"> </a></td>
						<td>
							<input id="txtCustfromno" type="text" class="txt c1" style="width:30%"/>
							<input id="txtCustfrom" type="text" class="txt c1" style="width:68%"/>
						</td>
						<td><span> </span><a id="lblPartfromno" class="lbl btn"> </a></td>
						<td>
							<input id="txtPartfromno" type="text" class="txt c1" style="width:30%"/>
							<input id="txtPartfrom" type="text" class="txt c1" style="width:68%"/>
						</td>

					</tr>
					<tr>
						<td><span> </span><a id="lblCustto" class="lbl btn"> </a></td>
						<td>
							<input id="txtCusttono" type="text" class="txt c1" style="width:30%"/>
							<input id="txtCustto" type="text" class="txt c1" style="width:68%"/>
						</td>
						<td><span> </span><a id="lblParttono" class="lbl btn"> </a></td>
						<td>
							<input id="txtParttono" type="text" class="txt c1" style="width:30%"/>
							<input id="txtPartto" type="text" class="txt c1" style="width:68%"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt num c1"/></td>
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td><input id="txtAccno" type="text" class="txt c1"/></td>
						<td> </td>
						<td> </td>
						<td> </td>												
					</tr>
					<tr>
						<td><span> </span><a id="lblUmmfromto" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtBummno" type="text" style="float:left; width:40%;"/>
							<span> </span>
							<input id="txtEummno" type="text" style="float:left; width:40%;"/>
						</td>
						<td> </td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td>
							<input id="txtWorker" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td>
							<input id="txtWorker2" type="text" class="txt c1"/>
						</td>
						<td> </td>
					</tr>
		        </table>
	        </div>
        </div>
        <input id="q_sys" type="hidden" />    
</body>
</html>
            