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
            var q_name = 'authority', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 150;
            var t_sqlname = 'authority_load';
            t_postname = q_name;
            var isBott = false;

            var afield, t_htm;
            var i, s1;
            var q_readonly = [];
            var q_readonlys = ['txtNoa','txtSssno','textTitle'];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];

            $(document).ready(function() {
                bbmKey = [];
                bbsKey = ['noa', 'sssno'];
                if(location.href.indexOf('?') < 0)// debug
                {
                    location.href = location.href + "?;;;a.sssno='z001'";
                    return;
                }
                q_bbsFit = 1;
                if(!q_paraChk())
                    return;
                main();
            });
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname);
                scroll("tbbs","box",1);
                q_mask(bbmMask);
                //q_gf('_qmenu');
                q_gt('qtitle','where=^^ 1=1 ^^', 0, 0, 0, "", r_accy);
                
            }
			
			var as_qlang=[];
            function q_gtPost(t_name) {
				switch (t_name) {
					case 'qtitle':
						as_qlang = _q_appendData("qtitle", "", true);
						var qf_qlang=false; //判斷是否有空白title 如果有再去抓qlang
						
						if (as_qlang[0] != undefined) {
							for(var i = 0; i < q_bbsCount; i++) {
								for(var j = 0; j < as_qlang.length; j++) {
									if($.trim($('#txtNoa_'+i).val()).toUpperCase()==$.trim(as_qlang[j].noa).toUpperCase()){
		                				$('#textTitle_'+i).val(as_qlang[j].title);
		                				break;
		                			}
								}
							}
							//檢查是否還有空白title
							for(var i = 0; i < q_bbsCount; i++) {
								if(emp($('#textTitle_'+i).val()))
									qf_qlang=true;
								if(qf_qlang)
									break;
							}
						}else{
							qf_qlang=true;
						}
						
						if(qf_qlang)
							q_gf('qlang.txt', 'qTitle');
						break;
				}
            }
            
            var t_qtitle=undefined;
            function q_gfPost() {
				if (q_gfTxt=='qlang.txt'){
					t_qtitle = xmlString.split('^^');
					for(var i = 0; i < q_bbsCount; i++) {
	                	if(t_qtitle!=undefined && emp($('#textTitle_'+i).val())){
	                		for(var k = 0; k < t_qtitle.length; k++) {
	                			if($.trim($('#txtNoa_'+i).val()).toUpperCase()==$.trim(t_qtitle[k].split(',')[0]).toUpperCase()){
	                				$('#textTitle_'+i).val(t_qtitle[k].split(',')[2]);
	                				break;
	                			}
	                		}
	                	}
	                }
	                qf_qlang=false;
				}
			}

            function bbsAssign() {
            	for (var j = 0; j < q_bbsCount; j++) {
					$('#check_All_'+j).click(function() {
						t_noq=$(this).attr('id').split('check_All_')[1];
						$('#chkPr_run_'+t_noq).prop('checked',$('#check_All_'+t_noq).prop('checked'));
						$('#chkPr_ins_'+t_noq).prop('checked',$('#check_All_'+t_noq).prop('checked'));
						$('#chkPr_modi_'+t_noq).prop('checked',$('#check_All_'+t_noq).prop('checked'));
						$('#chkPr_dele_'+t_noq).prop('checked',$('#check_All_'+t_noq).prop('checked'));
						$('#chkPr_seek_'+t_noq).prop('checked',$('#check_All_'+t_noq).prop('checked'));
						$('#chkPr_repo_'+t_noq).prop('checked',$('#check_All_'+t_noq).prop('checked'));
						$('#chkPrice_show_'+t_noq).prop('checked',$('#check_All_'+t_noq).prop('checked'));
						$('#chkPrice_modi_'+t_noq).prop('checked',$('#check_All_'+t_noq).prop('checked'));
					});
				}
                _bbsAssign();
                for(var i = 0; i < q_bbsCount; i++) {
                	if (as_qlang[0] != undefined) {
						for(var j = 0; j < as_qlang.length; j++) {
							if($.trim($('#txtNoa_'+i).val()).toUpperCase()==$.trim(as_qlang[j].noa).toUpperCase()){
		               			$('#textTitle_'+i).val(as_qlang[j].title);
		               			break;
		               		}
						}
					}
                	if(t_qtitle!=undefined && emp($('#textTitle_'+i).val())){
	                	for(var k = 0; k < t_qtitle.length; k++) {
	                		if($.trim($('#txtNoa_'+i).val()).toUpperCase()==$.trim(t_qtitle[k].split(',')[0]).toUpperCase()){
	                			$('#textTitle_'+i).val(t_qtitle[k].split(',')[2]);
	                			break;
	                		}
	                	}
	                }
                	if(q_cur==1||q_cur==2){
						$('#check_All_'+i).removeAttr('disabled');
					}else{
						$('#check_All_'+i).attr('disabled', 'disabled');
					}
                }
            }

            function btnOk() {
                sum();
                t_key = q_getHref();
                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['noa']&&!as['sssno']) {// Dont Save Condition
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
		
		        _btnModi();
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
            
			var scrollcount=1;
	        function scroll(viewid,scrollid,size){
	        	if(scrollcount>1)
	        		$('#box_'+(scrollcount-1)).remove();
				var scroll = document.getElementById(scrollid);
				var tb2 = document.getElementById(viewid).cloneNode(true);
				var len = tb2.rows.length;
				for(var i=tb2.rows.length;i>size;i--){
					tb2.deleteRow(size);
				}
				var bak = document.createElement("div");
				bak.id="box_"+scrollcount
				scrollcount++;
				scroll.appendChild(bak);
				bak.appendChild(tb2);
				bak.style.position = "absolute";
				bak.style.backgroundColor = "#cfc";
			    bak.style.display = "block";
				bak.style.left = 0;
				bak.style.top = "0px";
				scroll.onscroll = function(){
					bak.style.top = this.scrollTop+"px";
				}
			}
		</script>
		<style type="text/css">
            .seek_tr
		    {color:white; text-align:center; font-weight:bold;BACKGROUND-COLOR: #76a2fe}
		    #box{
				height:600px;
				width: 100%;
				overflow-y:auto;
				position:relative;
			}
		</style>
	</head>
	<body>
		<div id="box">
			<div  id="dbbs"  >
				<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:690px'  >
					<tr style='color:white; background:#003366;' >
						<td align="center" style="width:6%;"><a id='lblChk_all'> </a></td>
						<td class="td2" align="center" style="width:20%;"><a id='lblTitle'> </a></td>
						<td class="td8" align="center" style="width:6%;"><a id='lblPr_run'> </a></td>
						<td class="td3" align="center" style="width:6%;"><a id='lblPr_ins'> </a></td>
						<td class="td3" align="center" style="width:6%;"><a id='lblPr_modi'> </a></td>
						<td class="td3" align="center" style="width:6%;"><a id='lblPr_dele'> </a></td>
						<td class="td3" align="center" style="width:6%;"><a id='lblPr_seek'> </a></td>
						<td class="td3" align="center" style="width:6%;"><a id='lblPr_repo'> </a></td>
						<td class="td4" align="center" style="width:10%;"><a id='lblPrice_show'> </a></td>
						<td class="td4" align="center" style="width:10%;"><a id='lblPrice_modi'> </a></td>
					</tr>
					<tr  style='background:#cad3ff;'>
						<td align="center"><input id="check_All.*" type="checkbox" /></td>
						<td class="td2"><input class="txt" id="textTitle.*" type="text" style="width:98%; text-align: center;"  />
							<input class="txt" id="txtNoa.*" type="hidden" />
							<input class="txt" id="txtSssno.*" type="hidden" />
							<input class="txt" id="txtNamea.*" type="hidden" />
							<input id="recno.*" type="hidden" />
						</td>
						<td class="td2"><input id="chkPr_run.*" type="checkbox" /></td>
						<td class="td2"><input id="chkPr_ins.*" type="checkbox" /></td>
						<td class="td2"><input id="chkPr_modi.*" type="checkbox" /></td>
						<td class="td2"><input id="chkPr_dele.*" type="checkbox" /></td>
						<td class="td2"><input id="chkPr_seek.*" type="checkbox" /></td>
						<td class="td2"><input id="chkPr_repo.*" type="checkbox" /></td>
						<td class="td2"><input id="chkPrice_show.*" type="checkbox" /></td>
						<td class="td2"><input id="chkPrice_modi.*" type="checkbox" /></td>
					</tr>
				</table>
			</div>
		</div>
		<!--#include file="../inc/pop_modi.inc"-->
		<input id="q_sys" type="hidden" />
	</body>
</html>
