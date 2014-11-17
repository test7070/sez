<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
		    var t_ducc, t_dmon = '', msg_stkNew='已是最新庫存成本';
		    $(document).ready(function () {
		        _q_boxClose();
		        q_getId();
		        q_gf('', 'z_acbe');


		        $('#txtBdate').mask('99/99');
		        $('#txtEdate').mask('99/99');

		        $('#btnOk').click(function () {
		            var t_bdate = $('#txtBdate').val();
		            var t_edate = $('#txtEdate').val();
		            t_bdate = t_bdate.length == 0 ? '01/01' : t_bdate;
		            t_edate = t_edate.length == 0 ? '12/31' : t_edate;

		            var t_detail = $('#chkDetail')[0].checked;
		            t_detail = (t_detail ? 1 : 0);
		            var proj = $('#combProj').val();
		            var t_proj = (proj == 'zzz' ? '' : document.getElementById('combProj')[document.getElementById('combProj').selectedIndex].outerText);

		            var t_where = r_accy + ';' + r_cno + ';' + t_bdate + ';' + t_edate + ';' + $('#combPart').val() + ';' + proj + ';' + t_detail;
		            var t_para = "r_comp=" + q_getPara('sys.comp') + ",r_accy=" + r_accy + ",bdate=" + t_bdate + ",edate=" + t_edate + ",r_cno=" + r_cno + ",r_proj=" + t_proj;

		            q_gtx("z_acbe1", t_where + ";;" + t_para + ";;z_acbe;;" + q_getMsg('qTitle'));
		        });

		        $('#btnDucc').click(function () {
		            q_func('z_acbe.ca_ucc_mon', t_dmon + ',' + q_date().substr(0, r_lenm));
		            $('#btnDucc').val('庫存成本計算中.....');
		            $('#btnDucc').attr('disabled', 'disabled');
		        });
		    });

		    function q_funcPost(t_func, result) {
		        if (result.substr(0, 5) == '<Data') {
		            var Asss = _q_appendData('sss', '', true);
		        } else {
		            $('#btnDucc').val(msg_stkNew);
		        }
		    }

		    function q_gfPost() {
		            q_popAssign();
		            q_gt('ssspart',"where=^^ noa='"+r_userno+"' ^^", 0, 0, 0, "", r_accy+'_'+r_cno);
		            //q_gt('acpart', '', 0, 0, 0, "", r_accy + '_' + r_cno);
		            q_gt('proj', '', 0, 0, 0, "", '');

		            fbbm = q_getField('tbbm');
		            $('#tbbm td').children("input:text").each(function () { $(this).bind('keydown', function (event) { keypress_bbm(event, $(this), fbbm, 'btnOk'); }); });
		            t_ducc = q_getPara('acc.ducc');
		            var sys_proj = q_getPara('accc.proj');
		            if (sys_proj == 1)
		                $('.proj').show();
		            else
		                $('.proj').hide();

		            if (t_ducc == '1') {
		                q_gt('ducc', '');
		                $('#btnDucc').show();
		            }
		            else
		                $('#btnDucc').hide();
		    }

		    function q_boxClose(t_name) {
		    }
		    var ssspart;
		    function q_gtPost(t_name) {
		        var as;
                switch (t_name) {
		    	    case 'ducc':
		    	        var s1 = q_getMsg2('btnDucc', r_lang);
		    	        as = _q_appendData('ducc', '', true);
		    	        if (as.length > 0) {
		    	            t_dmon = as[0].mon;
		    	            $('#btnDucc').val(s1 + t_dmon + '～' + q_date().substr(0, r_lenm));
		    	        }
		    	        else {
		    	            $('#btnDucc').val(msg_stkNew);
		    	            $('#btnDucc').attr('disabled', 'disabled');
		    	        }
		    	        break;
                    case 'ssspart':
		    			ssspart = _q_appendData("ssspart","",true);
		    			q_gt('acpart','', 0, 0, 0, "", r_accy+'_'+r_cno);
		    			break;
					case 'acpart':
					 	t_part = "zzz@全部";
						var as = _q_appendData("acpart","",true);
						if(q_getPara('acc.lockPart')=='1' && r_rank<8){
							t_part = "";
							for ( i = 0; i < as.length; i++) {
								if(r_partno==as[i].noa){
									t_part = t_part + (t_part.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
									continue;
								}
								
								for ( j = 0; j < ssspart.length; j++) {
									if(as[i].noa==ssspart[j].partno)
										t_part = t_part + (t_part.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
								}
							}
						}else{
							for ( i = 0; i < as.length; i++) {
								t_part = t_part + (t_part.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
							}
						}
						q_cmbParse("combPart", t_part);
						break;
		            case 'proj':
		                t_part = "zzz@全部";
		                as = _q_appendData("proj", "", true);
		                for (i = 0; i < as.length; i++) {
		                    t_part = t_part + (t_part.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].proj;
		                }
		                q_cmbParse("combProj", t_part);
		                break;
				}
		    }
		</script>
	</head>
	<body>
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			 <div class="dview" id="dview" style="float: left;  width:15%; "  >
			 	<table class="tview" id="tview"   border="0" cellpadding='2'  cellspacing='0' >
			 	<tr>
			 		 <td class="td1"><a id='lblAcbe' class="lbl" style="font-size: xx-large;font-family:dfkai-sb;"></a></td>
			 	</tr>
			 </table>
			 </div>
			<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
			 <tr>
               <td class="td1"><a id="lblBdate"></a></td>
               <td class="td2"><input id="txtBdate"   type="text" style='width: 35%;'/><a id="lblSymbol" style="width: 10%;"></a>
               	<input id="txtEdate"   type="text" style='width: 35%;'/>
               </td>
               <td class="td3"><a id='lblYear'></a></td>
               <td class="td4"><input id="chkYear" type="checkbox" style=" "/></td>
              
               </tr>
           <tr>
               <td class="td1"><a id='lblPart'></a></td>
               <td class="td2"><select id="combPart" style="width: 35%;" ></select></td>
               <td class="td3"><a id='lblDetail'></a></td>
               <td class="td4"><input id="chkDetail" type="checkbox" style=" "/></td>  
               <td class="td5"><input class="btn"  id="btnDucc" type="button" value=''  /></td> 
            </tr>  
            <tr>
               <td class="proj"><a id='lblProj'></a></td>
               <td class="proj"><select id="combProj" style="width: 35%;" ></select></td>
            </tr> 
            </table>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>
           
          
