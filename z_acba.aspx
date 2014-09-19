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
		    $(document).ready(function () {
		        _q_boxClose();
		        q_getId();
		        q_gf('', 'z_acba');
		        $('#txtBdate').mask('99/99');
		        $('#txtEdate').mask('99/99');
		        //$('#txtBdate').val('01/01');

		        $('#btnOk').click(function () {
		            var t_bdate = $('#txtBdate').val();
		            var t_edate = $('#txtEdate').val();
		            t_bdate = t_bdate.length == 0 ? '01/01' : t_bdate;
		            t_edate = t_edate.length == 0 ? '12/31' : t_edate;
		            var t_part = $('#combPart').val();

                    var t_detail = $('#chkDetail')[0].checked;
		            t_detail = (t_detail ? 1 : 0);

		            var t_where = r_accy + ';' + r_cno + ';' + t_bdate + ';' + t_edate + ';' + t_part + ';' + t_detail;
		            var t_para = "r_comp=" + q_getPara('sys.comp') + ",r_accy=" + r_accy + ",bdate=" + t_bdate + ",edate=" + t_edate + ",r_part=" + t_part + ",r_cno=" + r_cno;

		            q_gtx("z_acba1", t_where + ";;" + t_para + ";;z_acba;;" + q_getMsg('qTitle'));
		        });
		    });
            function q_gfPost() {
                q_popAssign();
                q_gt('acpart', '', 0, 0, 0, "", r_accy + '_' + r_cno);
                fbbm = q_getField('tbbm');
                $('#tbbm td').children("input:text").each(function () { $(this).bind('keydown', function (event) { keypress_bbm(event, $(this), fbbm, 'btnOk'); }); });
            }
            function q_boxClose(s2) {
            }
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'acpart':
                        t_part = "zzz@全部";
                        var as = _q_appendData("acpart", "", true);
                        for (i = 0; i < as.length; i++) {
                            t_part = t_part + ',' + as[i].noa + '@' + as[i].part;
                        }
                        q_cmbParse("combPart", t_part);
                        break;
                }
                if(q_getPara('acc.lockPart')=='1' && r_rank<8){
		        	$('#combPart').val(r_partno);
		        	$('#combPart').attr('Disabled','Disabled');
		        }
            }
		</script>
		
	</head>
	<body>
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			 <div class="dview" id="dview" style="float: left;  width:8%; "  >
			 	<table class="tview" id="tview"   border="0" cellpadding='2'  >
			 	<tr>
			 		 <td class="td1"><a id='lblAcba' class="lbl" style="font-size: xx-large;font-family:dfkai-sb; "></a></td>
			 	</tr>
			 </table>
			</div>	
			<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
			 <tr>
               <td class="td1"><a id="lblBdate"></a></td>
               <td class="td2"><input id="txtBdate"   type="text" style='width: 35%;'/><a id="lblSymbol" style="width: 10%;"></a>
               	～<input id="txtEdate"   type="text" style='width: 35%;'/>
               </td>
                               <td class="td3"><a id='lblPart'></a></td>
               <td class="td4"><select id="combPart" style="width: 60%;" ></select></td>
                <td class="td5"><a id='lblDetail'></a></td>
               <td class="td6"><input id="chkDetail" type="checkbox" style=" "></td>
           </tr>
           </table>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
			 
		</div>
	</body>
</html>
           
          