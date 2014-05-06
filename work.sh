echo "SV bed"
awk '{count++;print $1"\t"$4"\t"$5"\t"$3"\t"$2count"\t""+"}' ../input/Combined.Deletion.final.valid.gff > Combined.Deletion.bed
awk '{count++;print $1"\t"$4"\t"$5"\t"$3"\t"$2count"\t""+"}' ../input/Combined.Deletion.final.valid.deletion.gff > Combined.Deletion.rectified.bed

echo "repeat bed"
perl repeatGFF2bed.pl --gff ../input/MSU_r7.fa.RepeatMasker.out.gff --project MSU7_repeat_bed
awk '{if (/TRF/){count++;print $1"\t"$4"\t"$5"\t"$3"\t"$2count"\t""+"}}' ../input/MSU_r7.fa.2.7.7.80.10.50.2000.dat.gff > MSU7_repeat_bed/MSU7_repeat_bed.TRF.bed

echo ""
python repeat_breakpoint.py --gff Combined.Deletion.bed --repeat MSU7_repeat_bed/MSU7_repeat_bed.TRF.bed --project TRF
python repeat_breakpoint.py --gff Combined.Deletion.bed --repeat MSU7_repeat_bed/MSU7_repeat_bed.CACTA.bed --project CACTA
python repeat_breakpoint.py --gff Combined.Deletion.bed --repeat MSU7_repeat_bed/MSU7_repeat_bed.MITE.bed --project MITE
python repeat_breakpoint.py --gff Combined.Deletion.bed --repeat MSU7_repeat_bed/MSU7_repeat_bed.MUDR.bed --project MUDR
python repeat_breakpoint.py --gff Combined.Deletion.bed --repeat MSU7_repeat_bed/MSU7_repeat_bed.DNA.bed --project DNA
python repeat_breakpoint.py --gff Combined.Deletion.bed --repeat MSU7_repeat_bed/MSU7_repeat_bed.COPIA.bed --project COPIA
python repeat_breakpoint.py --gff Combined.Deletion.bed --repeat MSU7_repeat_bed/MSU7_repeat_bed.GYPSY.bed --project GYPSY
python repeat_breakpoint.py --gff Combined.Deletion.bed --repeat MSU7_repeat_bed/MSU7_repeat_bed.RT.bed --project RT


python repeat_breakpoint.py --gff Combined.Deletion.rectified.bed --repeat MSU7_repeat_bed/MSU7_repeat_bed.TRF.bed --project TRF
python repeat_breakpoint.py --gff Combined.Deletion.rectified.bed --repeat MSU7_repeat_bed/MSU7_repeat_bed.CACTA.bed --project CACTA
python repeat_breakpoint.py --gff Combined.Deletion.rectified.bed --repeat MSU7_repeat_bed/MSU7_repeat_bed.MITE.bed --project MITE
python repeat_breakpoint.py --gff Combined.Deletion.rectified.bed --repeat MSU7_repeat_bed/MSU7_repeat_bed.MUDR.bed --project MUDR
python repeat_breakpoint.py --gff Combined.Deletion.rectified.bed --repeat MSU7_repeat_bed/MSU7_repeat_bed.DNA.bed --project DNA
python repeat_breakpoint.py --gff Combined.Deletion.rectified.bed --repeat MSU7_repeat_bed/MSU7_repeat_bed.COPIA.bed --project COPIA
python repeat_breakpoint.py --gff Combined.Deletion.rectified.bed --repeat MSU7_repeat_bed/MSU7_repeat_bed.GYPSY.bed --project GYPSY
python repeat_breakpoint.py --gff Combined.Deletion.rectified.bed --repeat MSU7_repeat_bed/MSU7_repeat_bed.RT.bed --project RT

