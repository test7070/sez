<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
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
            var q_name = 'historyordc', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as;
            var t_sqlname = 'historyordc_load';
            t_postname = q_name;
            var isBott = false;
            var afield, t_htm;
            var i, s1;
			brwCount2 = 0;
			brwCount = -1;			
            var decbbs = [];
            var decbbm = [];
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['txtMount',10,0,1],['txtMount2',10,0,1],['txtMiles',10,0,1]];
            var bbmMask = [];
            var bbsMask = [['txtDatea','999/99/99']];
			aPop = new Array(['txtStraddrno_','btnStraddr_','addr2','noa,addr','txtStraddrno_,txtStraddr_','addr2_b.aspx']
                ,['txtEndaddrno_','btnEndaddr_','addr2','noa,addr','txtEndaddrno_,txtEndaddr_','addr2_b.aspx']);
                
            $(document).ready(function() {
                bbmKey = [];
                bbsKey = ['noa', 'noq'];
                if (!q_paraChk())
                    return;

                main();
            });
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname);
                
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
				
            }
        
            function bbsAssign() {/// 表身運算式
                for (var i = 0; i < q_bbsCount; i++) {
                	$('#lblNo_' + i).text(i + 1);
                	if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                		$('#txtStraddrno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtStraddrno_', '');
                            $('#btnStraddr_'+n).click();
                        });
                        $('#txtEndaddrno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtEndaddrno_', '');
                            $('#btnEndaddr_'+n).click();
                        });
                	}
				}
				/*if(q_cur==2){
                	for(var i=0;i<q_bbsCount;i++){
                		$('#txtDatea_'+i).datepicker();
                	}
                }*/
				_bbsAssign();
            }
            function btnOk() {
                sum();
                t_key = q_getHref();
                q_gt('historyordc', "where=^^noa='"+t_key[1]+"' order by noa,noq desc^^", 0, 0, 0, "historyordc_maxnoq");
            }
            function bbsSave(as) {
                if (!as['memo'] && !as['straddr'] && !as['endaddr']) {
                    as[bbsKey[0]] = '';
                    return;
                }

                q_getId2('', as);

                return true;

            }

            function btnModi() {
                var t_key = q_getHref();

                if (!t_key)
                    return;

                _btnModi(1);

                for ( i = 0; i < abbsDele.length; i++) {
                    abbsDele[i][bbsKey[0]] = t_key[1];
                }
                $('#btnPlus').click();
                
            }

            function boxStore() {

            }

            function refresh() {
                _refresh();
                parent.$.fn.colorbox.resize({
					height : "95%"
				});
				
            }
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                /*if (t_para) {
                	for(var i=0;i<q_bbsCount;i++){
                		$('#txtDatea_'+i).datepicker('destroy');
                	}
                }*/
            }

            function sum() {
            }

            function q_gtPost(t_name) {  /// 資料下載後 ...
                switch (t_name) {
					case 'historyordc_maxnoq':
						var maxnoq = '000';
						var as = _q_appendData("historyordc", "", true);
						if (as[0] != undefined) {
							maxnoq=as[0].noq;
						}
						var string = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
						var n = string.indexOf(maxnoq.substring(0,1))*100 + parseInt(maxnoq.substring(1,3));
						var noq = '';
						for (var i = 0; i < q_bbsCount; i++) {
		                	if($('#txtNoq_'+i).val().length == 0){
		                		n++;
		                		noq = '00' + (n%100);
		                		noq = noq.substring(noq.length-2,noq.length);
		                		noq = string.substring(Math.floor(n/100),Math.floor(n/100)+1) + noq;
		                		$('#txtNoq_'+i).val(noq);
		                	}
		                }
		                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
						break;
					case q_name:
						break;
				}
            }

            

            function btnMinus(id) {
                _btnMinus(id);
                sum();
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                if (q_tables == 's')
                    bbsAssign();
                /// 表身運算式
            }

		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                BACKGROUND-COLOR: #76a2fe
            }
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;font-size: 14px;'  >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:1%;">
						<input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:10%;"><a>輸入日期</a></td>
					<td align="center" style="width:10%;"><a>出貨類型</a></td>
					<td align="center" style="width:15%;"><a>說明</a></td>
					<td align="center" style="width:8%;"><a>運費</a></td>
					<td align="center" style="width:8%;"><a>板數/趟次</a></td>
					<td align="center" style="width:8%;"><a>件數/才數</a></td>
					<td align="center" style="width:12%;"><a>發送地</a></td>
					<td align="center" style="width:12%;"><a>到著地</a></td>
					<td align="center" style="width:8%;"><a>里程數</a></td>
					
				</tr>
				<tr  style='background:#cad3ff;font-size: 14px;'>
					<td >
						<input class="btn"  id="btnMinus.*" type="button" value='－' style="font-weight: bold;"  />
						<input type="text" id="txtNoq.*" style="display:none;"/>
					</td>
					<td><input type="text" id="txtDatea.*" class="txt" style="width:95%;"  /></td>
					<td>
						<select id="cmbTypea.*" style="width:95%;"> 
							<option value="專車">專車</option>
							<option value="棧板">棧板</option>
							<option value="拖車">拖車</option>
							<option value="標案">標案</option>
							<option value="其他">其他</option>
						</select>
					</td>
					<td><input type="text" id="txtMemo.*" class="txt" style="width:95%;"  /></td>
					<td><input type="text" id="txtMoney.*" class="txt" style="width:95%;text-align: right;"  /></td>
					<td><input type="text" id="txtMount.*" class="txt" style="width:95%;text-align: right;"  /></td>
					<td><input type="text" id="txtMount2.*" class="txt" style="width:95%;text-align: right;"  /></td>
					<td>
						<input type="text" id="txtStraddrno.*" class="txt" style="float:left;width:45%;"  />
						<input type="text" id="txtStraddr.*" class="txt" style="float:left;width:45%;"  />
						<input type="button" id="btnStraddr.*" style="display:none;"/>
					</td>
					<td>
						<input type="text" id="txtEndaddrno.*" class="txt" style="float:left;width:45%;"  />
						<input type="text" id="txtEndaddr.*" class="txt" style="float:left;width:45%;"  />
						<input type="button" id="btnEndaddr.*" style="display:none;"/>
					</td>
					<td><input type="text" id="txtMiles.*" class="txt" style="width:95%;text-align: right;"  /></td>
				</tr>
			</table>
			<!--#include file="../inc/pop_modi.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
