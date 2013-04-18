<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
            var q_name = 'carsalary', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as;
            var t_sqlname = 'carsalary_load';
            t_postname = q_name;
            var isBott = false;

            var afield, t_htm;
            var i, s1;

            var decbbs = ['money'];
            var decbbm = [];
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            //var bbmNum_comma = [];
            var bbsNum = [['txtMoney', 10, 0, 1]];
            //var bbsNum_comma = ['txtMoney'];
            var bbmMask = [];
            var bbsMask = [['txtYear', '999']];
            aPop = [];

            $(document).ready(function() {
                bbmKey = [];
                bbsKey = ['noa', 'noq'];
                if(location.href.indexOf('?') < 0)// debug
                {
                    location.href = location.href + "?;;;noa='001-M9'";
                    return;
                }
                if(!q_paraChk())
                    return;
				brwCount2 = 0;
            	brwCount = -1;
                main();
            });
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname);
                //q_getFormat();
                //q_mask(bbsMask);
            }

            function q_gtPost(t_name) {

            }

            function bbsAssign() {
            	for(var j = 0; j < q_bbsCount; j++) {
           			if (!$('#btnMinus_' + j).hasClass('isAssign')) {
           				$('#txtId_'+j).change(function () {
           					t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							//搜尋資料庫有重複輸入跳出警告
           				});
           			}
           		}
                _bbsAssign();//'tbbs', bbsHtm, fbbs, '_', bbsMask, bbsNum, q_readonlys, 'btnPlus');
            }

            function btnOk() {
                sum();
                t_key = q_getHref();
                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['id']) {// Dont Save Condition
                    as[bbsKey[0]] = '';
                    return;
                }
                q_getId2('', as);
                return true;
            }

            function refresh() {
                _refresh();
            }

            function sum() {
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
                if(q_tables == 's')
                    bbsAssign();
            }
		</script>
		<style type="text/css">
            td a {
                font-size: 14px;
            }
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<!--#include file="../inc/pop_modi.inc"-->
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:2000px'  >
				<tr style='color:white; background:#003366;' >
					<td class="td1" align="center" style="width:1%; max-width:20px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td class="td2" align="center" style="width:3%;"><a id='lblYear'></a></td>
					<td class="td3" align="center" style="width:5%;"><a id='lblNamea'></a></td>
					<td class="td4" align="center" style="width:7%;"><a id='lblId'></a></td>
					<td class="td5" align="center" style="width:9%;"><a id='lblAddr'></a></td>
					<td class="td6" align="center" style="width:5%;"><a id='lblJan'></a></td>
					<td class="td7" align="center" style="width:5%;"><a id='lblFeb'></a></td>
					<td class="td8" align="center" style="width:5%;"><a id='lblMar'></a></td>
					<td class="td9" align="center" style="width:5%;"><a id='lblApr'></a></td>
					<td class="td10" align="center" style="width:5%;"><a id='lblMay'></a></td>
					<td class="td11" align="center" style="width:5%;"><a id='lblJun'></a></td>
					<td class="td12" align="center" style="width:5%;"><a id='lblJul'></a></td>
					<td class="td13" align="center" style="width:5%;"><a id='lblAug'></a></td>
					<td class="td14" align="center" style="width:5%;"><a id='lblSep'></a></td>
					<td class="td15" align="center" style="width:5%;"><a id='lblOct'></a></td>
					<td class="td16" align="center" style="width:5%;"><a id='lblNov'></a></td>
					<td class="td17" align="center" style="width:5%;"><a id='lblDec'></a></td>
					<td class="td18" align="center" ><a id='lblMemo'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td class="td1" align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  />
					</td>
					<td class="td2">
						<input class="txt" id="txtYear.*" type="text" style="width:95%; text-align:center;"/>
						<input class="txt"  id="txtNoa.*" type="hidden"  /><input id="txtNoq.*" type="hidden" />
					</td>
					<td class="td3">
						<input class="txt" id="txtNamea.*" type="text" style="width:95%; text-align:center;"  />
					</td>
					<td class="td4">
						<input class="txt" id="txtId.*" type="text" style="width:95%; text-align:center;"  />
					</td>
					<td class="td5">
					<input class="txt" id="txtAddr.*" type="text" style="width:95%; text-align:center;"   />
					</td>
					<td class="td6">
					<input class="txt" id="txtJan.*" type="text" style="width:95%; text-align: right;"  />
					</td>
					<td class="td7">
					<input class="txt" id="txtFeb.*" type="text" style="width:95%;"  />
					</td>
					<td class="td8">
					<input class="txt" id="txtMar.*" type="text" style="width:95%;"  />
					</td>
					<td class="td9">
					<input class="txt" id="txtApr.*" type="text" style="width:95%;"  />
					</td>
					<td class="td10">
					<input class="txt" id="txtMay.*" type="text" style="width:95%;"  />
					</td>
					<td class="td11">
					<input class="txt" id="txtJun.*" type="text" style="width:95%;"  />
					</td>
					<td class="td12">
					<input class="txt" id="txtJul.*" type="text" style="width:95%;"  />
					</td>
					<td class="td13">
					<input class="txt" id="txtAug.*" type="text" style="width:95%;"  />
					</td>
					<td class="td14">
					<input class="txt" id="txtSep.*" type="text" style="width:95%;"  />
					</td>
					<td class="td15">
					<input class="txt" id="txtOct.*" type="text" style="width:95%;"  />
					</td>
					<td class="td16">
					<input class="txt" id="txtNov.*" type="text" style="width:95%;"  />
					</td>
					<td class="td17">
					<input class="txt" id="txtDec.*" type="text" style="width:95%;"  />
					</td>
					<td class="td18">
                    	<input class="txt" id="txtMemo.*" type="text" style="width:95%;"  />
                    </td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
