/*1. How many contigs have a name that begins with the letters lp?*/
SELECT COUNT(DISTINCT mol_id) AS Answer FROM genome.contig WHERE regexp_instr(mol_name, '^lp')>0;
/*2. How many contigs are not plasmids?(Hint:havea look at their names.)*/
SELECT COUNT(DISTINCT mol_id) AS Answer FROM genome.contig WHERE mol_name not like '%plasmid%';
/*3. What is the longest contig?*/
SELECT mol_name, length(dna_sequence) FROM genome.contig WHERE length(dna_sequence)=(SELECT max(length(dna_sequence)) FROM genome.contig);
/*4. How many ORFs begin after the first 150 positions of their contig?*/
SELECT COUNT(DISTINCT orf_id) AS Answer FROM genome.orf WHERE orf_begin_coord>150;
/*5. Which ORFs occupy at least 10% of the length of their contig?*/
SELECT DISTINCT o.orf_id AS Answer FROM genome.orf o INNER JOIN genome.contig c ON o.mol_id=c.mol_id WHERE ((o.ORF_END_COORD)-(o.ORF_BEGIN_COORD))/ (LENGTH(c.DNA_SEQUENCE))>=0.1;
/*6. Which ORFs begin with a TC followed by 3 nucleotides and then followed by a TG?*/
SELECT DISTINCT o.orf_id AS Answer FROM genome.orf o INNER JOIN genome.contig c ON c.mol_id=o.mol_ID WHERE REGEXP_INSTR(substr(c.DNA_SEQUENCE, o.ORF_BEGIN_COORD, o.ORF_END_COORD),'^TC...TG.*')>0;
/*7.What are the names of the contigs that contain ORFs that begin with 2C’s separated from each other by 2 nucleotides and then followed by a G?*/
SELECT DISTINCT c.mol_name AS Answer FROM genome.contig c INNER JOIN genome.orf o ON c.mol_id=o.mol_ID WHERE REGEXP_INSTR(substr(c.DNA_SEQUENCE, o.ORF_BEGIN_COORD, o.ORF_END_COORD), '^C..CG.*')>0;
/*8. Which contigs contain ORFs that end in a T and C with one nucleotide between them?*/
SELECT DISTINCT c.mol_id, c.mol_name FROM genome.contig c INNER JOIN genome.orf o ON c.mol_id=o.mol_ID WHERE substr(c.DNA_SEQUENCE, o.ORF_BEGIN_COORD, o.ORF_END_COORD-o.ORF_BEGIN_COORD+1) LIKE '%T_C';
/*9. How many ORFs contain at least 4 A’s followed immediately by at least 3 C’?*/
SELECT COUNT(DISTINCT o.orf_id) AS Answer FROM genome.orf o INNER JOIN genome.contig c ON c.mol_id=o.mol_id WHERE substr(c.DNA_SEQUENCE, o.ORF_BEGIN_COORD, o.ORF_END_COORD-o.ORF_BEGIN_COORD+1) LIKE '%AAAACCC%';
