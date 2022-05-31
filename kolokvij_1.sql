# C:\xampp\mysql\bin\mysql -uroot --default_character_set=utf8 < C:\Users\MihaelPrgic\Documents\GitHub\dz\kolokvij_1.sql



drop database if exists kolokvij_1;
create database kolokvij_1;
use kolokvij_1;

create table sestra_svekar(
    sifra int not null primary key auto_increment,
    sestra int not null,
    svekar int not null
);

create table svekar(
    sifra int not null primary key auto_increment,
    bojaociju varchar(40) not null,
    prstena int,
    dukserica varchar(41),
    lipa decimal(13,8),
    eura decimal(12,7),
    majica varchar(35)
);

create table sestra(
    sifra int not null primary key auto_increment,
    introvertno bit,
    haljina varchar(31) not null,
    maraka decimal(16,6),
    hlace varchar(46) not null,
    narukvica int not null
);

create table zena(
    sifra int not null primary key auto_increment,
    treciputa datetime,
    hlace varchar(46),
    kratkamajica varchar(31) not null,
    jmbag char(11) not null,
    bojaociju varchar(39) not null,
    haljina varchar(44),
    sestra int not null
);

create table muskarac(
    sifra int not null primary key auto_increment,
    bojaociju varchar(50) not null,
    hlace varchar(30),
    modelnaocala varchar(43),
    maraka decimal(14,5) not null,
    zena int not null
);

create table mladic(
    sifra int not null primary key auto_increment,
    suknja varchar(50) not null,
    kuna decimal(16,8) not null,
    drugiputa datetime,
    asocijalno bit,
    ekstrovertno bit,
    dukserica varchar(48) not null,
    muskarac int
);

create table punac(
    sifra int not null primary key auto_increment,
    ogrlica int,
    gustoca decimal(14,9),
    hlace varchar(41) not null
);

create table cura(
    sifra int not null primary key auto_increment,
    novcica decimal(16,5) not null,
    gustoca decimal(18,6) not null,
    lipa decimal(13,10),
    ogrlica int not null,
    bojakose varchar(38),
    suknja varchar(36),
    punac int
);

alter table sestra_svekar add foreign key(sestra) references sestra(sifra);
alter table sestra_svekar add foreign key(svekar) references svekar(sifra);

alter table zena add foreign key(sestra) references sestra(sifra);
alter table muskarac add foreign key(zena) references zena(sifra);
alter table mladic add foreign key(muskarac) references muskarac(sifra);
alter table cura add foreign key(punac) references punac(sifra);

insert into muskarac(bojaociju,hlace,modelnaocala,maraka)
 values ('plava','bijele','bezbojne',1.1111),
        ('smeđa','crne','metalne',30.2),
        ('zelena','sive','okrugle',150.32);


insert into zena(treciputa,hlace,kratkamajica,jmbag,bojaociju,haljina)
 values (null,'uske','crvena','11112223232','plava','uska'),
        (null,'široke','plava','42345312642','smeđa','široka'),
        (null,'kratke','crna','54321412211','smeđa','ljetna');

insert into sestra(introventno,haljina,maraka,hlace,narukvica)
values(null,'uska',null,'široke',1),
      (null,'široka',null,'uske',2),
      (null,'kratka',null,'kratke',3);        

insert into svekar(bojaociju,prstena,dukserica,lipa,eura,majica)
values('plava',null,null,null,null,null),
      ('smeđa',null,null,null,null,null),
      ('zelena',null,null,null,null,null); 



insert into sestra_svekar(sestra,svekar)
values (1,3),
       (2,2),
       (3,1);

update cura set gustoca=15.77;


delete from mladic where kuna >15.78;

select kratkamajica from zena where hlace like '%ana%';

select a.dukserica, b.asocijalno, c.hlace,
d.hlace, e.haljina
from svekar a inner join sestra_svekar ss 
on a.sifra=ss.svekar
inner join sestra e on ss.sestra = e.sifra 
inner join zena d on e.sifra=d.sestra 
inner join muskarac c on d.sifra=c.zena 
inner join mladic b on c.sifra = b.muskarac 
where d.hlace like 'a%' and e.haljina like '%ba%'
order by c.hlace DESC;

select a.haljina, a.maraka
from sestra a inner join sestra_svekar ss 
on a.sifra=ss.sestra where a.sifra not in (select sestra from sestra_svekar);


