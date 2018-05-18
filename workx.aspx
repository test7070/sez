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
        var q_name="workx";
        var q_readonly = ['txtNoa','txtWorker'];
        var bbmNum = [['txtCheckmount', 12, 2 , 1],['txtDiscardmount', 12, 2 , 1]]; 
        var bbmMask = []; 
        q_sqlCount = 6; brwCount = 6; brwCount2=20; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
        //ajaxPath = ""; //  execute in Root
		
        $(document).ready(function () {
            bbmKey = ['noa'];
            q_brwCount();
            q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy) 
            $('#txtNoa').focus
        });
		aPop = new Array(
					['txtStationno', 'lblStationno', 'station', 'noa,station', 'txtStationno,txtStation', 'station_b.aspx'],
					//['txtFactoryno', 'lblFactoryno', 'factory', 'noa,factory', 'txtFactoryno,txtFactory', 'factory_b.aspx'],
					['txtSimechno', 'lblSimech', 'mech', 'noa,mech', 'txtSimechno,txtSimech', 'mech_b.aspx'],
					['txtSomechno', 'lblSomech', 'mech', 'noa,mech', 'txtSomechno,txtSomech', 'mech_b.aspx'],
					['txtSoprocessno', 'lblSoprocess', 'process', 'noa,process', 'txtSoprocessno,txtSoprocess', 'process_b.aspx'],
					['txtSiprocessno', 'lblSiprocess', 'process', 'noa,process', 'txtSiprocessno,txtSiprocess', 'process_b.aspx'],
					['txtProductno', 'lblProductno', 'ucaucc', 'noa,product,unit', 'txtProductno,txtProduct,txtUnit', 'ucaucc_b.aspx']
		);
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
        	q_mask(bbmMask);
        	bbmMask = [['txtDatea', r_picd], ['txtTrandatea', r_picd]];
			q_mask(bbmMask);
        }
        
        function q_boxClose(s2) { 
             var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
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
          q_box('workx_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));  
        }
        function btnIns() {
            _btnIns();
            $('#txtNoa').val('AUTO');
            $('#txtDatea').val(q_date());
            $('#txtTrandatea').val(q_date());
            $('#txtTypea').focus();
        }

        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtDatea').focus();
        }

        function btnPrint() {
 
        }
        function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock();
        }
        function btnOk() {
           Lock(); 
           $('#txtWorker').val(r_name)

			var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_workx') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);


         }

        function wrServer( key_value) {
            var i;

            xmlSql = '';
            if (q_cur == 2)   
                xmlSql = q_preXml();

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], '','',2);
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
                width: 25%;
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
                width: 73%;
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
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="overflow:hidden;">
        <div class="dview" id="dview" style="float: left;  width:35%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>                
                <td align="center" style="width:15%"><a id='vewDatea'></a></td>
                <td align="center" style="width:30%"><a id='vewNoa'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='noa'>~noa</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 63%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>            
            <tr style="height:1px;">
				<td> </td>
				<td> </td>
				<td> </td>
				<td> </td>
				<td class="tdZ"> </td>
			</tr>
            <tr>
               <td class="td1"><span> </span><a id='lblTypea' class="lbl"></a></td>
               <td class="td2"><input id="txtTypea"  type="text" class="txt c1" /></td>
               <td class="td3"><span> </span><a id='lblNoa' class="lbl"></a></td>
               <td class="td4"><input id="txtNoa"  type="text" class="txt c1"/></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblDatea' class="lbl"></a></td>
               <td class="td2"><input id="txtDatea"  type="text" class="txt c1"/></td>
               <td class="td1"><span> </span><a id='lblTrandatea' class="lbl"></a></td>
               <td class="td2"><input id="txtTrandatea"  type="text" class="txt c1"/></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblStationno' class="lbl btn"></a></td>
               <td class="td2"><input id="txtStationno"  type="text" class="txt c2"/>
               <input id="txtStation"  type="text" class="txt c3"/></td>
               <td class="td1"><span> </span><a id='lblSign' class="lbl"></a></td>
               <td class="td2"><input id="txtSign"  type="text" class="txt c1"/></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblSotype' class="lbl"></a></td>
               <td class="td2"><input id="txtSotype"  type="text" class="txt c1"/></td>
               <td class="td1"><span> </span><a id='lblSomech' class="lbl btn"></a></td>
               <td class="td2"><input id="txtSomechno"  type="text" class="txt c2"/>
               				   <input id="txtSomech"  type="text" class="txt c3"/></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblSitype' class="lbl"></a></td>
               <td class="td2"><input id="txtSitype"  type="text" class="txt c1"/></td>
               <td class="td1"><span> </span><a id='lblSimech' class="lbl btn"></a></td>
               <td class="td2"><input id="txtSimechno"  type="text" class="txt c2"/>
               				   <input id="txtSimech"  type="text" class="txt c3"/></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblWorktype' class="lbl"></a></td>
               <td class="td2"><input id="txtWorktype"  type="text" class="txt c1"/></td>
               <td class="td1"><span> </span><a id='lblWorkno' class="lbl"></a></td>
               <td class="td2"><input id="txtWorkno"  type="text" class="txt c1"/></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblProductno' class="lbl btn"></a></td>
               <td class="td2" colspan="2"><input id="txtProductno"  type="text" class="txt c2"/>
               <input id="txtProduct"  type="text" class="txt c3"/></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblSpec' class="lbl"></a></td>
               <td class="td2"><input id="txtSpec"  type="text" class="txt c1"/></td>
               <td class="td1"><span> </span><a id='lblUnit' class="lbl"></a></td>
               <td class="td2"><input id="txtUnit"  type="text" class="txt c1"/></td>
            </tr>
            <tr>
               <!--<td class="td1"><span> </span><a id='lblSoprocess' class="lbl"></a></td>
               <td class="td2"><input id="txtSoprocess"  type="text" class="txt c1"/></td>-->
               <!--<td class="td1"><span> </span><a id='lblSiprocess' class="lbl"></a></td>
               <td class="td2"><input id="txtSiprocess"  type="text" class="txt c1"/></td>-->
               <td class="td1"><span> </span><a id='lblSoprocess' class="lbl btn"> </a></td>
               <td class="td2"><input id="txtSoprocessno"  type="text" class="txt c2"/>
               				   <input id="txtSoprocess"  type="text" class="txt c3"/>
				</td>
				<td class="td3"><span> </span><a id='lblSiprocess' class="lbl btn"> </a></td>
               <td class="td4"><input id="txtSiprocessno"  type="text" class="txt c2"/>
               				   <input id="txtSiprocess"  type="text" class="txt c3"/>
				</td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblDescribe' class="lbl"></a></td>
               <td class="td2" colspan="3"><input id="txtDescribe"  type="text" class="txt c1"/></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblCheckmount' class="lbl"></a></td>
               <td class="td2"><input id="txtCheckmount"  type="text" class="txt num c1"/></td>
               <td class="td1"><span> </span><a id='lblDiscardmount' class="lbl"></a></td>
               <td class="td2"><input id="txtDiscardmount"  type="text" class="txt num c1"/></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblWorker' class="lbl"></a></td>
               <td class="td2"><input id="txtWorker"  type="text" class="txt c1"/></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblMemo' class="lbl"></a></td>
               <td class="td2" colspan="3"><input id="txtMemo"  type="text" class="txt c1"/></td>
            </tr>
        </table>
        </div>
        </div> 
        <input id="q_sys" type="hidden" />    
</body>
</html>
