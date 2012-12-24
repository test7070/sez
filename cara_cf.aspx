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
            var q_name = "cara_cf";
            var q_readonly = [];
            var bbmNum = [];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Noa';
            q_desc=1;
			//q_alias='a';
			
            $(document).ready(function() {
               // bbmKey = ['noa'];
                //q_brwCount();
                //q_gt(q_name, q_content, q_sqlCount, 1)
                main();
            });

            //////////////////   end Ready
            function main() {
                /*if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);*/
               q_gf('', q_name);
            }
            			
            function mainPost() {
            }

            function q_boxClose(s2) {///   q_boxClose 2/4
                var
                ret;
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
                    case q_name:
                    	if(q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }
            
            function q_gfPost() {
				q_popAssign();
				q_getFormat();
				bbmMask = [['txtMon', r_picm],['txtDiscount', '99']];
                q_mask(bbmMask);
				q_langShow();
				
				$('#btnIns').hide();
				$('#btnModi').hide();
				$('#btnDele').hide();
				$('#btnSeek').hide();
				$('#btnPrint').hide();
				$('#btnPrevPage').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnNextPage').hide();
				$('#btnOk').hide();
				$('#btnCancel').hide();
				$('#btnSign').hide();
				$('#pageNow').hide();
				$('#pageAll').hide();
				
				$('#txtMon').val(q_date().substr(0,6));
				
				$('#btnImport').click(function() {
                	q_func('', "");
                	//執行後端結轉function
                });
			}

            function btnOk() {
                
            }

            function _btnSeek() {
                
            }
            function bbsAssign() {
            	for(var j = 0; j < q_bbsCount; j++) {
           			
           		}
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                _btnModi();
            }

            function btnPrint() {
            }


            ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改

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
                /// 表身運算式
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
            .tbbs a {
                font-size: medium;
            }
            .tbbs a {
                font-size: medium;
            }
            .tbbs tr.error input[type="text"] {
                color: red;
            }
            .tbbs
        	{
	            FONT-SIZE: medium;
	            COLOR: blue ;
	            TEXT-ALIGN: left;
	             BORDER:1PX LIGHTGREY SOLID;
	             width:100% ; height:98% ;  
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
		<div id='dmain' >
			<div class='dbbm' style="width: 73%;float: left;">
				<table class="tbbm"  id="tbbm"  border="0" cellpadding='2'  cellspacing='5'>
					<tr class="tr1">
						<td class="td1"><span> </span><a id='lblMon' class="lbl"></a></td>
						<td class="td2"><input id="txtMon"  type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblDiscount' class="lbl"></a></td>
						<td class="td4"><input id="txtDiscount"  type="text" class="txt c1"/></td>
						<td class="td5"><input id="btnImport" type="button" /></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
