select director,collect_set(title) from movies where country ='USA' group by director;