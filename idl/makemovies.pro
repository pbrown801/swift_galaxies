pro makemovies

SNname='SN2006bp'




filters=['w2','m2','w1','uu','bb','vv']

commandsfile=SNname+'_rateimagecommands.txt'
openw, lun, commandsfile, /get_lun


for f=0,n_elements(filters)-1 do begin

	filter=filters[f]

	startfile=SNname+"_"+filter+".img"
	outfile=SNname+"_"+filter+"_rate.img"
	tempfile=SNname+"_"+filter+"_temp.img"
	tempfile2=SNname+"_"+filter+"_temp2.img"

	PRINTF, lun,'rm ' + outfile
	PRINTF, lun,'rm ' + tempfile
	PRINTF, lun,'rm ' + tempfile2


	expose = [0.0]
	k=1
	n=2

	PRINTF, lun,'fextract ' + startfile+'[0] '+ outfile


	while n GT 1 do begin
		x = MRDFITS(startfile,k,h)
		n = N_ELEMENTS(x)


		expose = [expose,FLOAT(FXPAR(h,'EXPOSURE'))]
		print, expose[1]
	
		exposure=expose[1]

		if n gt 1  then PRINTF, lun,'fextract ' + startfile+'['+strtrim(string(k),1)+'] '+ tempfile
		if n gt 1 then PRINTF, lun,'fcarith ' + tempfile+'[1] '+strtrim(string(exposure),1)+' '+ tempfile2 +' / '
		if n gt 1  then PRINTF, lun,'ftappend '+ tempfile2 + ' ' + outfile
		if n gt 1  then PRINTF, lun,'rm '+ tempfile 
		if n gt 1  then PRINTF, lun,'rm '+ tempfile2 


		k=k+1
	endwhile
endfor

close, lun
free_lun, lun

;;;; for some reason third extension didn't work

;ds9 -rgb -red SN2006bp_vv_rate.img  -green SN2006bp_uu_rate.img  -blue SN2006bp_m2_rate.img          -rgb -red SN2006bp_vv_rate.img\[2\]  -green SN2006bp_uu_rate.img\[2\]  -blue SN2006bp_m2_rate.img\[2\]          -rgb -red SN2006bp_vv_rate.img\[3\]  -green SN2006bp_uu_rate.img\[3\]  -blue SN2006bp_m2_rate.img\[3\]         -rgb -red SN2006bp_vv_rate.img\[4\]  -green SN2006bp_uu_rate.img\[4\]  -blue SN2006bp_m2_rate.img\[4\]         -rgb -red SN2006bp_vv_rate.img\[5\]  -green SN2006bp_uu_rate.img\[5\]  -blue SN2006bp_m2_rate.img\[5\]         -rgb -red SN2006bp_vv_rate.img\[6\]  -green SN2006bp_uu_rate.img\[6\]  -blue SN2006bp_m2_rate.img\[6\]         -rgb -red SN2006bp_vv_rate.img\[7\]  -green SN2006bp_uu_rate.img\[7\]  -blue SN2006bp_m2_rate.img\[7\]         -rgb -red SN2006bp_vv_rate.img\[8\]  -green SN2006bp_uu_rate.img\[8\]  -blue SN2006bp_m2_rate.img\[8\]         -rgb -red SN2006bp_vv_rate.img\[9\]  -green SN2006bp_uu_rate.img\[9\]  -blue SN2006bp_m2_rate.img\[9\]           -rgb -red SN2006bp_vv_rate.img\[10\]  -green SN2006bp_uu_rate.img\[10\]  -blue SN2006bp_m2_rate.img\[10\]       -rgb -red SN2006bp_vv_rate.img\[11\]  -green SN2006bp_uu_rate.img\[11\]  -blue SN2006bp_m2_rate.img\[11\]       -rgb -red SN2006bp_vv_rate.img\[12\]  -green SN2006bp_uu_rate.img\[12\]  -blue SN2006bp_m2_rate.img\[12\]       -rgb -red SN2006bp_vv_rate.img\[13\]  -green SN2006bp_uu_rate.img\[13\]  -blue SN2006bp_m2_rate.img\[13\]       -rgb -red SN2006bp_vv_rate.img\[14\]  -green SN2006bp_uu_rate.img\[14\]  -blue SN2006bp_m2_rate.img\[14\]       -rgb -red SN2006bp_vv_rate.img\[15\]  -green SN2006bp_uu_rate.img\[15\]  -blue SN2006bp_m2_rate.img\[15\]       &



;ds9 -rgb -red SN2006bp_vv.img  -green SN2006bp_uu.img  -blue SN2006bp_m2.img          -rgb -red SN2006bp_vv.img\[5\]  -green SN2006bp_uu.img\[5\]  -blue SN2006bp_m2.img\[5\]          -rgb -red SN2006bp_vv.img\[8\]  -green SN2006bp_uu.img\[8\]  -blue SN2006bp_m2.img\[8\]    &     

print, 'final stop'
stop
end




