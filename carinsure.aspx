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
            var q_name = 'carinsure', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as;
            var t_sqlname = 'carinsure_load';
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
            var bbsNum = [['txtMoney', 10, 0, 1],['txtCmoney', 10, 0, 1],['txtVmoney', 10, 0, 1]];
            //var bbsNum_comma = ['txtMoney'];
            var bbmMask = [];
            var bbsMask = [['txtBdate', '999/99/99'], ['txtInmon', '999/99'], ['txtEdate', '999/99/99'], ['txtStopdate', '999/99/99']];
            aPop = [['txtInsurerno_', 'btnInsurer_', 'insurer', 'noa,comp', 'txtInsurerno_,txtInsurer_', 'insurer_b.aspx']];

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
            	for(var j = 0; j < (q_bbsCount==0?1:q_bbsCount); j++) {
           			if (!$('#btnMinus_' + j).hasClass('isAssign')) {
           				$('#txtInsurerno_'+j).change(function () {
           					t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							if(b_seq>='1'){
								$('#txtBdate_'+b_seq).val($('#txtEdate_0').val());
								$('#txtEdate_'+b_seq).val((dec($('#txtBdate_'+b_seq).val().substr(0,3))+1)+$('#txtBdate_'+b_seq).val().substr(3,7));
								$('#txtInmon_'+b_seq).val($('#txtBdate_'+b_seq).val().substr(0,6));
							}
           				});
           				$('#txtCmoney_'+j).change(function () {
           					t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2)
								$('#txtMoney_'+b_seq).val(q_add(q_float('txtCmoney_'+b_seq),q_float('txtVmoney_'+b_seq)));
           				});
           				
           				$('#txtVmoney_'+j).change(function () {
           					t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							if(q_cur==1 || q_cur==2)
								$('#txtMoney_'+b_seq).val(q_add(q_float('txtCmoney_'+b_seq),q_float('txtVmoney_'+b_seq)));
           				});
           				
           			}
           		}
                _bbsAssign();//'tbbs', bbsHtm, fbbs, '_', bbsMask, bbsNum, q_readonlys, 'btnPlus');
                for(var j = 0; j < q_bbsCount; j++) {//跳至空白行
                	if(emp($('#txtInsurerno_'+j).val())){
                		$('#txtInsurerno_'+j).focus();
                		break;
                	}
                }
                if(q_cur==1 || q_cur==2){
                    $('.btnFiles').removeAttr('disabled', 'disabled');
                }else{
                    $('.btnFiles').attr('disabled', 'disabled');
                }
                $('.btnFiles').change(function() {
                    event.stopPropagation(); 
                    event.preventDefault();
                    if(q_cur==1 || q_cur==2){}else{return;}
                    var txtOrgName = replaceAll($(this).attr('id'),'btn','txt').split('_');
                    var txtName = replaceAll($(this).attr('id'),'btn','txt');
                    file = $(this)[0].files[0];
                    if(file){
                        Lock(1);
                        var ext = '';
                        var extindex = file.name.lastIndexOf('.');
                        if(extindex>=0){
                            ext = file.name.substring(extindex,file.name.length);
                        }
                        $('#'+txtOrgName[0]+'name_'+txtOrgName[1]).val(file.name);
                        //$('#'+txtName).val(guid()+Date.now()+ext);
                        //106/05/22 不再使用亂數編碼
                        $('#'+txtName).val(file.name);
                        
                        fr = new FileReader();
                        fr.fileName = $('#'+txtName).val();
                        fr.readAsDataURL(file);
                        fr.onprogress = function(e){
                            if ( e.lengthComputable ) { 
                                var per = Math.round( (e.loaded * 100) / e.total) ; 
                                $('#FileList').children().last().find('progress').eq(0).attr('value',per);
                            }; 
                        }
                        fr.onloadstart = function(e){
                            $('#FileList').append('<div styly="width:100%;"><progress id="progress" max="100" value="0" ></progress><progress id="progress" max="100" value="0" ></progress><a>'+fr.fileName+'</a></div>');
                        }
                        fr.onloadend = function(e){
                            $('#FileList').children().last().find('progress').eq(0).attr('value',100);
                            console.log(fr.fileName+':'+fr.result.length);
                            var oReq = new XMLHttpRequest();
                            oReq.upload.addEventListener("progress",function(e) {
                                if (e.lengthComputable) {
                                    percentComplete = Math.round((e.loaded / e.total) * 100,0);
                                    $('#FileList').children().last().find('progress').eq(1).attr('value',percentComplete);
                                }
                            }, false);
                            oReq.upload.addEventListener("load",function(e) {
                                Unlock(1);
                            }, false);
                            oReq.upload.addEventListener("error",function(e) {
                                alert("資料上傳發生錯誤!");
                            }, false);
                                
                            oReq.timeout = 360000;
                            oReq.ontimeout = function () { alert("Timed out!!!"); }
                            oReq.open("POST", 'carinsure_upload.aspx', true);
                            oReq.setRequestHeader("Content-type", "text/plain");
                            oReq.setRequestHeader("FileName", escape(fr.fileName));
                            oReq.send(fr.result);//oReq.send(e.target.result);
                        };
                    }
                    ShowDownlbl();
                });
                ShowDownlbl();
            }
            
            var guid = (function() {
                function s4() {return Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1);}
                return function() {return s4() + s4() + s4() + s4();};
            })();
            
            function ShowDownlbl() {                
                $('.lblDownload').text('').hide();
                $('.lblDownload').each(function(){
                    var txtfiles=replaceAll($(this).attr('id'),'lbl','txt');
                    var lblfiles=replaceAll($(this).attr('id'),'lbl','lbl');
                    var txtOrgName = replaceAll($(this).attr('id'),'lbl','txt').split('_');
                    
                    if(!emp($('#'+txtfiles).val()))
                        $(this).text('下載').show();
                                            
                    $('#'+lblfiles).click(function(e) {
                        if(txtfiles.length>0)
                            $('#xdownload').attr('src','carinsure_download.aspx?FileName='+$('#'+txtOrgName[0]+'name_'+txtOrgName[1]).val()+'&TempName='+$('#'+txtfiles).val());
                        else
                            alert('無資料...!!');
                    });
                });
            }

            function btnOk() {
                sum();
                t_key = q_getHref();
                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['bdate']) {// Dont Save Condition
                    as[bbsKey[0]] = '';
                    return;
                }
                q_getId2('', as);
                return true;
            }

            function refresh() {
                _refresh();
                ShowDownlbl();
            }

            function sum() {
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(t_para){
                    $('.btnFiles').attr('disabled', 'disabled');
                }else{
                    $('.btnFiles').removeAttr('disabled', 'disabled');
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
                ShowDownlbl();
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
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:1500px'  >
				<tr style='color:white; background:#003366;' >
					<td class="td1" align="center" style="width:1%; max-width:20px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td class="td2" align="center" style="width:150px;"><a id='lblInsurer'> </a></td>
					<td class="td3" align="center" style="width:70px;"><a id='lblBdate'> </a></td>
					<td class="td4" align="center" style="width:70px;"><a id='lblEdate'> </a></td>
					<td class="td5" align="center" style="width:60px;"><a id='lblInmon'> </a></td>
					<td class="td6" align="center" style="width:80px;"><a id='lblCmoney'> </a></td>
					<td class="td6" align="center" style="width:80px;"><a id='lblVmoney'> </a></td>
					<td class="td6" align="center" style="width:80px;"><a id='lblMoney'> </a></td>
					<td class="td7" align="center" style="width:60px;"><a id='lblKind'> </a></td>
					<td class="td9" align="center" style="width:130px;"><a id='lblInsurecard'> </a></td>
					<td class="td8" align="center" style="width:130px;"><a id='lblInsuresheet'> </a></td>
					<td class="td10" align="center" style="width:70px;"><a id='lblStopdate'> </a></td>
					<td class="td11" align="center" ><a id='lblMemo' style="width:140px;"> </a></td>
					<td align="center"><a id='lblFiles_s' style="width:250px;"> 圖片上傳 </a></td>
					
				</tr>
				<tr  style='background:#cad3ff;'>
					<td class="td1" align="center"><input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  /></td>
					<td class="td2">
						<input class="txt"  id="txtInsurerno.*" type="text" style="width:20%;"  />
						<input class="txt" id="txtInsurer.*" type="text" style="width:70%;"   />
						<input class="txt c1"  id="txtNoa.*" type="hidden"  />
	                    <input id="txtNoq.*" type="hidden" />
					</td>
					<td class="td3"><input class="txt" id="txtBdate.*" type="text" style="width:95%; text-align:center;"  /></td>
					<td class="td4"><input class="txt" id="txtEdate.*" type="text" style="width:95%; text-align:center;"  /></td>
					<td class="td5"><input class="txt" id="txtInmon.*" type="text" style="width:95%; text-align:center;"   /></td>
					<td class="td6"><input class="txt" id="txtCmoney.*" type="text" style="width:95%; text-align: right;"  /></td>
					<td class="td6"><input class="txt" id="txtVmoney.*" type="text" style="width:95%; text-align: right;"  /></td>
					<td class="td6"><input class="txt" id="txtMoney.*" type="text" style="width:95%; text-align: right;"  /></td>
					<td class="td7"><input class="txt" id="txtKind.*" type="text" style="width:95%;"  /></td>
					<td class="td9"><input class="txt" id="txtInsurecard.*" type="text" style="width:95%;"  /></td>
					<td class="td8"><input class="txt" id="txtInsuresheet.*" type="text" style="width:95%;"  /></td>
					<td class="td10"><input class="txt" id="txtStopdate.*" type="text" style="width:95%; text-align:center;"  /></td>
					<td class="td11"><input class="txt" id="txtMemo.*" type="text" style="width:95%;"  /></td>
					<td class="td12">
                        <span style="float: left;"> </span>
                        <input type="file" id="btnFiles.*" class="btnFiles" value="選擇檔案"/>
                        <input id="txtFiles.*"  type="hidden"/>
                        <a id="lblFiles.*" class='lblDownload lbl btn' style="color: #4297D7;font-weight: bolder;cursor: pointer;"></a>
                        <input id="txtFilesname.*" type="hidden"/>
                    </td>
				</tr>
			</table>
		</div>
		<iframe id="xdownload" style="display:none;"> </iframe>
		<input id="q_sys" type="hidden" />
	</body>
</html>
