<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = 'car2', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 10;
            var t_sqlname = 'car2_checknotice_load';
            t_postname = q_name;
            var isBott = false;

            var afield, t_htm;
            var i, s1;
            var q_readonly = [];
            var q_readonlys = ['txtCarowner','txtNoa','txtCaryeartw','txtPassdate','txtCarbrand','txtCardeal'];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [['txtCheckdate', '999/99/99'],['txtNotice', '999/99/99'],['txtPassdate', '999/99/99'],['txtCaryeartw', '999/99']];

            $(document).ready(function() {
                bbmKey = [];
                bbsKey = ['noa', 'noq'];
                if(location.href.indexOf('?') < 0)// debug
                {
                    location.href = location.href + "?;;;carno='002-XC' and (caritemno='501' or caritemno='502') order by mon desc";
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
                q_mask(bbmMask);
                
                $('#btnTop').hide();
                $('#btnPrev').hide();
                $('#btnNext').hide();
                $('#btnBott').hide();
            }

            function q_gtPost(t_name) {

            }

            function bbsAssign() {
                
                for(var j = 0; j < q_bbsCount; j++) {
                }
                _bbsAssign();//_bbsAssign('tbbs', bbsHtm, fbbs, '_', bbsMask, bbsNum, q_readonlys, 'btnPlus');
            }

            function btnOk() {
                sum();
                t_key = q_getHref();
                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['noa']) {// Dont Save Condition
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
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:white; background:#003366;' >
					<td class="td2" align="center" style="width:10%;"><a id='lblNoa'></a></td>
					<td class="td8" align="center" style="width:10%;"><a id='lblCarowner'></a></td>
					<td class="td3" align="center" style="width:10%;"><a id='lblPassdate'></a></td>
					<td class="td3" align="center" style="width:10%;"><a id='lblCaryeartw'></a></td>
					<td class="td3" align="center" style="width:10%;"><a id='lblCarbrand'></a></td>
					<td class="td3" align="center" style="width:10%;"><a id='lblCardeal'></a></td>
					<td class="td3" align="center" style="width:10%;"><a id='lblCheckdate'></a></td>
					<td class="td4" align="center" style="width:10%;"><a id='lblNotice'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td class="td2"><input class="txt" id="txtNoa.*" type="text" style="width:95%; text-align: center;"  /></td>
					<td class="td2"><input class="txt" id="txtCarowner.*" type="text" style="width:95%; text-align: center;"/></td>
					<td class="td2"><input class="txt" id="txtPassdate.*" type="text" style="width:95%; text-align: center;"/></td>
					<td class="td2"><input class="txt" id="txtCaryeartw.*" type="text" style="width:95%; text-align: center;"/></td>
					<td class="td2"><input class="txt" id="txtCarbrand.*" type="text" style="width:95%; text-align: center;"/></td>
					<td class="td2"><input class="txt" id="txtCardeal.*" type="text" style="width:95%; text-align: center;"/></td>
					<td class="td2"><input class="txt" id="txtCheckdate.*" type="text" style="width:95%; text-align: center;"/></td>
					<td class="td2"><input class="txt" id="txtNotice.*" type="text" style="width:95%; text-align: center;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
