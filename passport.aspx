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
        var q_name="passport";
        var q_readonly = ['txtNoa'];
        var bbmNum = []; 
        var bbmMask = []; 
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';

        aPop = [['txtCarno', 'lblCarno', 'car2', 'carno,carownerno,carowner', 'txtCarno,txtCarownerno,txtCarowner', 'car2_b.aspx']
            , ['txtTggno', 'lblTgg', 'Tgg', 'noa,nick', 'txtTggno,txtTgg', 'tgg_b.aspx']
            ];

        $(document).ready(function () {
            bbmKey = ['noa'];
            brwCount2 = 15;
            q_brwCount();
            q_gt(q_name, q_content, q_sqlCount, 1)
            $('#txtNoa').focus
        });
        
            function currentData() {
            }

            currentData.prototype = {
                data : [],
                /*排除的欄位,新增時不複製*/
                exclude : ['txtNoa', 'txtDatea', 'txtBdate', 'txtEdate', 'txtMemo'],
                /*記錄當前的資料*/
                copy : function() {
                    curData.data = new Array();
                    for (var i in fbbm) {
                        var isExclude = false;
                        for (var j in curData.exclude) {
                            if (fbbm[i] == curData.exclude[j]) {
                                isExclude = true;
                                break;
                            }
                        }
                        if (!isExclude) {
                            curData.data.push({
                                field : fbbm[i],
                                value : $('#' + fbbm[i]).val()
                            });
                        }
                    }
                },
                /*貼上資料*/
                paste : function() {
                    for (var i in curData.data) {
                        $('#' + curData.data[i].field).val(curData.data[i].value);
                    }
                }
            };
            var curData = new currentData();
            
       function main() {
           if (dataErr)   
           {
               dataErr = false;
               return;
           }

            mainForm(0); // 1=Last  0=Top

        }  ///  end Main()


        function mainPost() {
            bbmMask = [['txtDatea', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd], ['txtBtime', '99:99'], ['txtEtime', '99:99']]; 
            q_mask(bbmMask);
           
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

            q_box('passport_s.aspx', q_name + '_s', "500px", "310px", q_getMsg( "popSeek"));
        }

        function btnIns() {
                if ($('#Copy').is(':checked')) {
                    curData.copy();
                }
                _btnIns();
                if ($('#Copy').is(':checked')) {
                    curData.paste();
                }
                $('#txtNoa').val('AUTO'); 
                $('#txtDatea').val(q_date()).focus();
                
      
        }

        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;

            _btnModi();
            refreshBbm();
            $('#txtCarno').focus();
        }

        function btnPrint() {
 
        }
       function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock();
            }
        function btnOk() {
            	var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (q_cur ==1)
                     q_gtnoa(q_name, replaceAll((t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                     wrServer(t_noa);
        }


        function wrServer( key_value) {
            var i;
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
                width: 30%;
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
    </style>
</head>
	<body>
			<!--#include file="../inc/toolbar.inc"-->
			<div id='dmain' style="overflow:hidden;">
				<div class="dview" id="dview" style="float: left;  width:35%;"  >
					<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
						<tr>
                            <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                            <td align="center" style="width:25%"><a id='vewCarno'> </a></td>
                            <td align="center" style="width:25%"><a id='vewTgg'> </a></td>
                            <td align="center" style="width:40%"><a id='vewBdate'> </a></td>
                        </tr>
                        <tr>
                            <td >
                            <input id="chkBrow.*" type="checkbox" style=''/>
                            </td>
                            <td align="center" id='carno'>~carno</td>
                            <td align="center" id='tgg'>~tgg</td>
                            <td align="center" id='bdate edate'>~bdate ~ ~edate</td>
                        </tr>
					</table>
				</div>
				<div class='dbbm' style="width: 55%;float: left;">
					<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
						<tr>
							<td class="td1"><span> </span><a id='lblNoa' class="lbl"></a></td>
							<td class="td2"><input id="txtNoa"  type="text" class="txt c1" /></td>
							<td class="td3"><span> </span><a id='lblDatea' class="lbl"></a></td>
                            <td class="td4"><input id="txtDatea"  type="text" class="txt c1" /></td>
                            <td class="td5" style="text-align: center;">
                                <input id="Copy" type="checkbox" />
                                <span> </span><a id="lblCopy">複製</a>
                            </td>
						</tr>
						<tr>
                            <td class="td1"><span> </span><a id='lblCarno' class="lbl btn"></a></td>
                            <td class="td2"><input id="txtCarno"  type="text"  class="txt c1"/></td>
                            <td class="td3"><span> </span><a id='lblCarowner' class="lbl"></a></td>
                            <td class="td4" colspan="2"><input id="txtCarownerno"  type="text"  class="txt c1" style="width: 40%"/>
                                            <input id="txtCarowner"  type="text"  class="txt c1" style="width: 50%"/> </td>

                        </tr>
                        <tr>
                            <td class="td1"><span> </span><a id='lblTgg' class="lbl btn"></a></td>
                            <td class="td2" colspan="3"><input id="txtTggno"  type="text"  class="txt c1" style="width: 30%"/>
                                            <input id="txtTgg"  type="text"  class="txt c1" style="width: 70%"/> </td>
                        </tr>
                        <tr>
                            <td class="td1"><span> </span><a id='lblProductno' class="lbl"></a></td>
                            <td class="td2"><input id="txtProductno"  type="text"  class="txt c1"/></td>
                            <td class="td3"><span> </span><a id='lblProduct' class="lbl"></a></td>
                            <td class="td4" colspan="2"><input id="txtProduct"  type="text"  class="txt c1"/></td>
                        </tr>
                        <tr>
                            <td class="td1"><span> </span><a id='lblTypea' class="lbl"></a></td>
                            <td class="td2" colspan="2"><input id="txtTypea"  type="text"  class="txt c1"/></td>
                            <td class="td3"><span> </span><a id='lblWeight' class="lbl"></a></td>
                            <td class="td4"><input id="txtWeight"  type="text"  class="txt c1"/></td>
                        </tr>
                        <tr>
                            <td class="td1"><span> </span><a id='lblRoute' class="lbl"></a></td>
                            <td class="td2" colspan="4">
                                <textarea id="txtRoute" rows='5' cols='10' style="width:99%; height: 50px;"> </textarea>
                            </td>
                        </tr>
                        <tr>
                            <td class="td1" ><span> </span><a id='lblBdate' class="lbl"> </a></td>
                            <td class="td2" colspan="2">
                                <input id="txtBdate"  type="text" class="txt" style="width: 120px;"/>
                                <a style="float:left;">~</a>
                                <input id="txtEdate"  type="text" class="txt" style="width: 120px;"/>
                            </td>
                            <td class="td4" ><span> </span><a id='lblBtime' class="lbl"> </a></td>
                            <td class="td5">
                                <input id="txtBtime"  type="text" class="txt" style="width: 55px;"/>
                                <a style="float:left;">~</a>
                                <input id="txtEtime"  type="text" class="txt" style="width: 55px;"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="td1"><span> </span><a id='lblMemo' class="lbl"></a></td>
                            <td class="td2" colspan="4">
                                <textarea id="txtMemo" rows='5' cols='10' style="width:99%; height: 50px;"> </textarea>
                            </td>
                        </tr>
			</table>
			</div>
			</div>
			<input id="q_sys" type="hidden" />
	</body>
</html>
