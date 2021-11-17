select vacc_id,vacc_name,vacc_vocab ,replace(replace (trim('|' from
NVL(p1,'')||'|'||
NVL(p2,'')||'|'||
NVL(p3,'')||'|'||
NVL(p4,'')||'|'||
NVL(p5,'')||'|'||
NVL(p6,'')
),'|||','|'),'||','|') as diseases,
replace(replace (trim('|' from
NVL(m1,'')||'|'||
NVL(m2,'')||'|'||
NVL(m3,'')||'|'||
NVL(m4,'')||'|'||
NVL(m5,'')||'|'||
NVL(m6,'')
),'|||','|'),'||','|') as mechanism,
formulation
from (
  select concept_id as vacc_id, concept_name as vacc_name, vocabulary_id as vacc_vocab,
  case 
    when lower(concept_name) ~ 'tdp|dtp|dtap' then 'diphtheria|tetanus|pertussis'
    when lower(concept_name) ~ 'dt |td ' then 'diphtheria|tetanus'
    when lower(concept_name) ~ 'mmrv' then 'measles|mumps|rubella|varicella'
    when lower(concept_name) ~ 'mmr' then 'measles|mumps|rubella'
    when lower(concept_name) ~ 'meningococcal|neisseria meningitidis' and lower(concept_name) !~ 'diphtheria|toxoid|tetanus'  then 'meningococcal'
    when lower(concept_name) ~ 'diptheria|diphtheria' then 'diphtheria'
    when lower(concept_name) ~ 'measles' then 'measles'
    when lower(concept_name) ~ 'pneumococcal|streptococcus pneumoniae' then 'pneumococcal'
    when lower(concept_name) ~ 'hepatitis a|hep a' then 'hepatitis a'
    when lower(concept_name) ~ 'rabies' then 'rabies'
    when lower(concept_name) ~ 'rotavirus' then 'rotavirus'
    when lower(concept_name) ~ 'papilloma|hpv' then 'human papilomavirus'
    when lower(concept_name) ~ 'covid' then 'covid-19'
    when lower(concept_name) ~ 'typhoid|salmonella typhi' then 'typhoid'
    when lower(concept_name) ~ 'plague' then 'plague'
    when lower(concept_name) ~ 'anthrax' then 'anthrax'
    when lower(concept_name) ~ 'cholera' then 'cholera'
  end as p1,
  case 
    when lower(concept_name) ~ 'rubella' then 'rubella'
    when lower(concept_name) ~ 'tetanus' then 'tetanus' 
  end as p2 ,
  case
    when lower(concept_name) ~ 'mumps' then 'mumps' 
    when lower(concept_name) ~ 'pertussis' then 'pertussis'
  end as p3, 
  case 
    when lower(concept_name) ~ 'varicella|zoster' then 'varicella'
    when lower(concept_name) ~ 'polio' then 'poliovirus'
  end as p4,
  case 
    when lower(concept_name) ~ 'hepatitis b|hep b' then 'hepatitis b'
  end as p5,
  case 
    when lower(concept_name) ~ 'haemophilus|hib ' then 'haemophilus influenza'
    when lower(concept_name) ~ 'influenza' then 'influenza'
    when lower(concept_name) ~ 'yellow fever' then 'yellow fever'
    when lower(concept_name) ~ 'japanese encephalitis' then 'japanese encephalitis'
    when lower(concept_name) ~ 'smallpox' then 'smallpox'
    when lower(concept_name) ~ 'adenovirus' then 'adenovirus'
    when lower(concept_name) ~ 'dengue' then 'dengue'
    when lower(concept_name) ~ 'hepatitis c' then 'hepatitis c'
    when lower(concept_name) ~ 'hepatitis e' then 'hepatitis e'
    when lower(concept_name) ~ 'venezuelan equine encephalitis' then 'Venezuelan equine encephalitis'
  end as p6,


  case 
    when lower(concept_name) ~ 'tdp|dtp' and lower(concept_name)~ 'toxoid' then 'diphtheria toxoid|tetanus toxoid|whole cell pertussis'
    when lower(concept_name) ~ 'tdap|dtap' and lower(concept_name)~ 'toxoid' then 'diphtheria toxoid|tetanus toxoid|acellular pertussis'
    when lower(concept_name) ~ 'dt |td ' and lower(concept_name)~ 'toxoid' then 'diphtheria toxoid|tetanus toxoid'
    when lower(concept_name) ~ 'meningococcal|neisseria meningitidis' and lower(concept_name) !~ 'diphtheria|tetanus|toxoid' and  lower(concept_name) ~ 'polysaccharide' then 'meningococcal polysaccharide'
    when lower(concept_name) ~ 'meningococcal|neisseria meningitidis' and lower(concept_name) !~ 'diphtheria|tetanus|toxoid' and  lower(concept_name) ~ 'oligosaccharide' then 'meningococcal oligosaccharide'
    when lower(concept_name) ~ 'meningococcal|neisseria meningitidis' and lower(concept_name) !~ 'diphtheria|tetanus|toxoid' and  lower(concept_name) ~ 'conjugate' then 'meningococcal conjugate'
    when lower(concept_name) ~ 'meningococcal|neisseria meningitidis' and lower(concept_name) !~ 'diphtheria|tetanus|toxoid' and  lower(concept_name) ~ 'recombinant' then 'meningococcal recombinant'
    when lower(concept_name) ~ 'diptheria|diphtheria' and lower(concept_name)~ 'toxoid' then 'diphtheria toxoid'
    when lower(concept_name) ~ 'diptheria|diphtheria' and lower(concept_name)~ 'antitoxin' then 'diphtheria antitoxin'
    --when lower(concept_name) ~ 'measles' then 'measles'
    when lower(concept_name) ~ 'pneumococcal|streptococcus pneumoniae' and  lower(concept_name) ~ 'polysaccharide' then 'pneumococcal polysaccharide'
    when lower(concept_name) ~ 'pneumococcal|streptococcus pneumoniae' and  lower(concept_name) ~ 'conjugate' then 'pneumococcal conjugate'
    when lower(concept_name) ~ 'hepatitis a|hep a' and lower(concept_name) ~ 'live' then 'hepatitis a live'
    when lower(concept_name) ~ 'hepatitis a|hep a' and lower(concept_name) ~ 'inactiv' then 'hepatitis a inactivated'
    --when lower(concept_name) ~ 'rabies' then 'rabies'
    when lower(concept_name) ~ 'rotavirus' and lower(concept_name) ~ 'live' then 'rotavirus live'
    --when lower(concept_name) ~ 'papilloma|hpv' then 'human papilomavirus'
    when lower(concept_name) ~ 'covid' and lower(concept_name) ~ 'mrna' then 'covid-19 mRNA'
    when lower(concept_name) ~ 'covid' and lower(concept_name) ~ 'vector' then 'covid-19 vector'
    when lower(concept_name) ~ 'typhoid|salmonella typhi' and lower(concept_name) ~ 'live' then 'typhoid live'
    when lower(concept_name) ~ 'typhoid|salmonella typhi' and lower(concept_name) ~ 'conjugate' then 'typhoid conjugate'
    when lower(concept_name) ~ 'typhoid|salmonella typhi' and lower(concept_name) ~ 'acetone' then 'typhoid acetone-killed'
    when lower(concept_name) ~ 'typhoid|salmonella typhi' and lower(concept_name) ~ 'polysaccharide' then 'typhoid polysaccharide'    
  end as m1,
  case 
    --when lower(concept_name) ~ 'rubella' then 'rubella'
    when lower(concept_name) ~ 'tetanus' and lower(concept_name)~ 'toxoid' then 'tetanus toxoid' 
  end as m2 ,
  case
    --when lower(concept_name) ~ 'mumps' then 'mumps' 
    when lower(concept_name) ~ 'dtap|pertussis' and lower(concept_name)~ 'acellular' then 'acellular pertussis'
    when lower(concept_name) ~ 'pertussis' and lower(concept_name)~ 'whole' then 'whole cell pertussis'
  end as m3, 
  case 
    when lower(concept_name) ~ 'varicella|zoster' and lower(concept_name)~ 'live' then 'varicella live'
    when lower(concept_name) ~ 'varicella|zoster' and lower(concept_name)~ 'recombinant' then 'varicella recombinant'
    when lower(concept_name) ~ 'polio' and lower(concept_name)~ 'live' then 'poliovirus live'
    when lower(concept_name) ~ 'polio' and lower(concept_name)~ 'inactivated' then 'poliovirus inactivated'
  end as m4,
  case 
    when lower(concept_name) ~ 'hepatitis b|hep b' and lower(concept_name)~ 'recombinant' then 'hepatitis b recombinant'
  end as m5,
  case 
    when lower(concept_name) ~ 'haemophilus|hib '  and  lower(concept_name) ~ 'conjugate' then 'haemophilus influenza conjugate'
    when lower(concept_name) ~ 'influenza' and lower(concept_name)~ 'live' then 'influenza live'
    when lower(concept_name) ~ 'influenza' and lower(concept_name)~ 'recomb' then 'influenza recomb'
    --when lower(concept_name) ~ 'yellow fever' then 'yellow fever'
    --when lower(concept_name) ~ 'japanese encephalitis' then 'japanese encephalitis'
    --when lower(concept_name) ~ 'smallpox' then 'smallpox'
    when lower(concept_name) ~ 'adenovirus'  and lower(concept_name)~ 'live' then 'adenovirus live'
    --when lower(concept_name) ~ 'dengue' then 'dengue'
    --when lower(concept_name) ~ 'hepatitis c' then 'hepatitis c'
    --when lower(concept_name) ~ 'hepatitis e' then 'hepatitis e'
    when lower(concept_name) ~ 'venezuelan equine encephalitis' and lower(concept_name)~ 'live'  then 'Venezuelan equine encephalitis live'
    when lower(concept_name) ~ 'venezuelan equine encephalitis' and lower(concept_name)~ 'inactivated'  then 'Venezuelan equine encephalitis inactivated'
  end as m6,
  
regexp_substr(concept_name,'\w+\s?valent') as formulation

select regexp_substr('7 valent','(\w*\svalent)')


from rwdex_omop_cprd.concept
where 
(
-- Influenza and Haemophilus influenza vaccines
lower(concept_name) ~ 'influenza|h3n2|h1n1|haemophilus|hib '
or
-- Diphteria, Pertussis, Tetanus and Polio vaccines 
lower(concept_name) ~ 'diphtheria|tetanus|pertussis|tdap|tdp |poliovirus|polio |poliomyelitis'
or
-- Measles, Mumps, Rubella, Varicella and Zoster vaccines 
lower(concept_name) ~ 'measles|rubella|mumps|varicella|mmr|zoster'
or 
-- Pneumococcal, Meningococcal and Encephalitis vaccines 
lower(concept_name) ~ 'pneumococcal|meningococcal|encephalitis|streptococcus pneumoniae|neisseria meningitidis'
or
-- BCG, Typhoid, Botulinum, Cholera and Rabies vaccines
lower(concept_name) ~ 'rabies|typhoid|salmonella typhi'
or
-- Herpes group vaccine, HPV and Hepatitis 
lower(concept_name) ~ 'hepatitis|hep a|hep b|hep c|herpes|papilloma|hpv|hantavirus|cytomegalovirus'
or
-- other vaccines
lower(concept_name) ~ 'vaccine|adenovirus|anthrax|bacillus anthracis|junin|leishmaniasis|lyme |malaria|yellow fever|tularemia|yersinia pestis|brucella melitensis|rickettsia prowazekii|brucella abortus' -- discuss last 4 topics
)
-- filter junk concepts
and lower(concept_name) !~ 'not\sreceive|bacillus calmette\-guerin|bcg|did not|respiratory vaccine|heparin|imm glob|immune|immuno|topical oil|neurotox|sinusin|neti wash flu|allantoin|upper respiratory staph|pleo san brucel|archangelica|pallet|pellet|hp\_c|guna\-tf|homocord|homochord|homeopathic|condylomata|hp\_x|remedy|influenzinum|thuja|biotox|echinacea|arnica|arsenicum|antimony|pharyngitis|glucose|panel|factor|aconitum|nipple|acyclovir|rosmarinus|extract|moraxella|geissospermum|nosodes|hyaluronate|skin test|travel|destruction|antibody panel|resection|screen'
-- defining domain 
and domain_id in ('Drug','Procedure')
and vocabulary_id in (/*'NDC', 'CPT4', 'HCPCS',*/ 'CVX'/*, 'ICD9Proc', 'ICD10PCS', 'RxNorm'*/)
)
;