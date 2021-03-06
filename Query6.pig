artists = LOAD '/Users/Rajiv/files/artists_en.json' USING JsonLoader('id:chararray, firstName:chararray,lastName:chararray,yearOfBirth:chararray');

movies = LOAD '/Users/Rajiv/files/movies_en.json' USING JsonLoader('id:chararray, title:chararray,year:chararray,genre:chararray,summary:chararray, country:chararray,director:tuple(id:chararray,lastName:chararray,firstName:chararray,yearOfBirth:chararray),actors:bag{(id:chararray,role:chararray)}');

movies = FOREACH movies GENERATE id, title, year, genre, country,director,actors;

usaMovies = FILTER movies by country =='USA';

q5Pass1 = FOREACH usaMovies GENERATE id,FLATTEN(actors);

q6Pass1 = FOREACH (JOIN q5Pass1 by actors::id,artists by id) GENERATE q5Pass1::id,artists::id,artists::firstName,artists::lastName,artists::yearOfBirth;

STORE q6Pass1 into '/Users/hadoop/Query6Results';