<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = 'ssspart', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 15;
            var t_sqlname = 'ssspart_load';
            t_postname = q_name;
            var isBott = false;
            var afield, t_htm;
            var i, s1;

            var decbbs = [];
            var decbbm = [];
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['txtRate',5,2,0],['txtRank',1,0,0]];
            var bbmMask = [];
            var bbsMask = [];
			var t_authRun=false;
            $(document).ready(function() {
                bbmKey = [];
                bbsKey = ['noa','noq'];
                if (location.href.indexOf('?') < 0){
                	
                }// debug
                if (!q_paraChk())
                    return;
                var t_where = "where=^^ a.noa='" + q_name + "' and a.sssno='"+r_userno+"' ^^";
				q_gt('authority', t_where, 0, 0, 0, "getauthRun", r_accy);
            });
            
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                if(t_authRun)
					mainBrow(6, t_content, t_sqlname, t_postname);
				else
					alert('無使用權限');
            }

		    function mainPost() {
		        q_getFormat();
		        q_gt('part', '', 0, 0, 0, "");
		    }
            function bbsAssign() {/// 表身運算式
        		for(var i = 0; i < q_bbsCount; i++) {
        			$('#cmbPartno_' + i).change(function(){
						t_IdSeq = -1; 
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if(dec($('#txtRank_' + b_seq).val()) <1 || dec($('#txtRank_' + b_seq).val()) > 8){
							$('#txtRank_' + b_seq).val('1');
							return;
						}
        			});
        			$('#txtRank_' + i).change(function(){
						t_IdSeq = -1; 
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if(dec($('#txtRank_' + b_seq).val()) <1 || dec($('#txtRank_' + b_seq).val()) > 8){
							alert(q_getMsg('lblRank') + '輸入範圍為1~8');
							$('#txtRank_' + b_seq).val('1');
							return;
						}
        			});
        		}
                _bbsAssign();
                
                if (q_getPara('sys.project').toUpperCase()=='DC'){
                	$('.rate').hide();
                }
            }

            function btnOk() {
                t_key = q_getHref();

                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['rank'] && !as['partno'] && !as['rate']) {
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
            }

            function boxStore() {

            }

            function refresh() {
                //        refresh2();
                _refresh();
            }

            function q_gtPost(t_name) {  /// 資料下載後 ...
		        switch (t_name) {
		        	case 'getauthRun':
						var as = _q_appendData("authority", "", true, true);
						if (as[0] != undefined) {
							if (as[0]["pr_run"] == "true"){
								t_authRun=true;
							}
						}
						if(r_rank>=8){
							t_authRun=true;
						}
						main();
						break;
			    	case 'part':
						var as = _q_appendData("part", "", true);
						if (as[0] != undefined) {
							var t_item = "@";
							for (i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
							}
							q_cmbParse("cmbPartno", t_item, 's');
							refresh(q_recno);  /// 第一次需要重新載入
	
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
		        }
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
            }

            function btnMinus(id) {
            	b_seq = id.split('_')[1];
            	$('#cmbPartno_' + b_seq).val('');
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                if (q_tables == 's')
                    bbsAssign();
                /// 表身運算式
            }
            function refresh(recno) {
                _refresh(recno);
				for(var j = 0; j < q_bbsCount;j++){
					if (abbs[j].partno != undefined) {
						$('#cmbPartno_' + j).val(abbs[j].partno);
					}
				}
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
			<table align="center" id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:80%'  >
				<tr style='color:White; background:#003366;' >
					<td align="center">
						<input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  />
					</td>
					<td align="center"><a id='lblPart'> </a></td>
					<td align="center" class="rate"><a id='lblRate'> </a></td>
					<td align="center"><a id='lblRank'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center" style="width:1%;">
						<input class="btn"  id="btnMinus.*" type="button" value='－' style="font-weight: bold; "  />
					</td>
					<td style="width:6%;">
						<select id="cmbPartno.*"  style="float:left;width:95%;" > </select>
					</td>
					<td style="width:6%;"  class="rate">
						<input class="txt num" id="txtRate.*" type="text" maxlength='90' style="width:98%;text-align: right;"   />
					</td>
					<td style="width:6%;">
						<input class="txt" id="txtRank.*" type="text" maxlength='90' style="width:98%;text-align: center;"   />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/pop_modi.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
