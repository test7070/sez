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
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            var q_name = 'view_ordcs', t_bbsTag = 'tbbs', t_content = " field=productno,product,unit,mount,weight,noa,no2,price,total,memo,notv,trandate,spec,dime,width,lengthb,lengthc,style,class  order=odate ", afilter = [], bbsKey = ['noa', 'no2'], t_count = 0, as;
            var t_sqlname = 'ordcs_load2';
            t_postname = q_name;
            //brwCount2 = 12;
            var isBott = false;
            /// 是否已按過 最後一頁
            var txtfield = [], afield, t_data, t_htm;
            var i, s1;

            brwCount = -1;

            $(document).ready(function() {
                main();
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
            }

            function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
				}
				_bbsAssign();
				if(q_getPara('sys.isspec')!='1')
					$('.isSpec').hide();
			}

            function q_gtPost() {

            }

            function refresh() {
                _refresh();
                $('#checkAllCheckbox').click(function() {
                    $('input[type=checkbox][id^=chkSel]').each(function() {
                        var t_id = $(this).attr('id').split('_')[1];
                        if (!emp($('#txtProductno_' + t_id).val()))
                            $(this).attr('checked', $('#checkAllCheckbox').is(':checked'));
                    });
                });
                if(q_getPara('sys.isspec')!='1')
					$('.isSpec').hide();
                
                $('#btnTop').hide();
                $('#btnPrev').hide();
                $('#btnNext').hide();
                $('#btnBott').hide();
            }
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 300px;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 450px;
                /*margin: -1px;
                 border: 1px black solid;*/
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
                width: 20%;
            }
            .tbbm .tdZ {
                width: 1%;
            }
            td .schema {
                display: block;
                width: 95%;
                height: 0px;
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
                width: 100%;
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
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
        </style>
	</head>
	<body>
		<div id='dbbs' class='dbbs'>
            <table id="tbbs" class='tbbs'>
                <tr style='color:white; background:#003366;' >
					<td align="center" style="width:20px;">
					<input type="checkbox" id="checkAllCheckbox"/>
					</td>
					<td align="center" style="width:20px;"></td>
					<td align="center" style="width:100px;"><a id='lblProductno'> </a></td>
					<td align="center" style="width:250px;"><a id='lblProduct'> </a> <a id='lblSpec' class="isSpec"> </a></td>
					<td align="center" style="width:80px;"><a id='lblUnit'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMount'> </a></td>
					<td align="center" style="width:80px;"><a id='lblPrice'> </a></td>
					<td align="center" style="width:200px;"><a id='lblNoa'> </a></td>
					<td align="center" style="width:200px;"><a id='lblMemo'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center"><input id="chkSel.*" type="checkbox"  /></td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input class="txt"  id="txtProductno.*" type="text" style="width:95%;" /></td>
					<td>
						<input class="txt" id="txtProduct.*" type="text" style="width:95%;" />
						<input class="txt isSpec" id="txtSpec.*" type="text" style="width:98%;" />
					</td>
					<td><input class="txt" id="txtUnit.*" type="text" style="width:95%;"/></td>
					<td><input class="txt" id="txtMount.*" type="text" style="width:95%; text-align:right;"/></td>
					<td><input class="txt" id="txtPrice.*" type="text" style="width:95%; text-align:right;"/></td>
					<td>
						<input class="txt" id="txtNoa.*" type="text" style="width:75%;float:left;"/>
						<input class="txt" id="txtNo2.*" type="text" style="width:15%;float:left;"/>
					</td>
					<td>
						<input class="txt" id="txtMemo.*" type="text" style="width:95%;"/>
						<input id="recno.*" type="hidden" />
						<input id="txtStyle.*" type="hidden" />
						<input id="txtSpec.*" type="hidden" />
						<input id="txtWidth.*" type="hidden" />
						<input id="txtLengthb.*" type="hidden" />
						<input id="txtLengthc.*" type="hidden" />
						<input id="txtDime.*" type="hidden" />
						<input id="txtClass.*" type="hidden" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/pop_ctrl.inc"-->
		</div>
	</body>
</html>
