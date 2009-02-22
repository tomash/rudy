module ruby.c.st;

extern (C) {

  alias size_t st_data_t;

  struct st_hash_type {
    int (*compare)();
    int (*hash)();
  }

  struct st_table_entry {}

  struct st_table {
    st_hash_type *type;
    int num_bins;
    int num_entries;
    st_table_entry **bins;
  }

  enum st_retval {ST_CONTINUE, ST_STOP, ST_DELETE, ST_CHECK};
  st_table *st_init_table (st_hash_type *);
  st_table *st_init_table_with_size (st_hash_type *, int);
  st_table *st_init_numtable ();
  st_table *st_init_numtable_with_size (int);
  st_table *st_init_strtable ();
  st_table *st_init_strtable_with_size (int);
  int st_delete (st_table *, st_data_t *, st_data_t *);
  int st_delete_safe (st_table *, st_data_t *, st_data_t *, st_data_t);
  int st_insert (st_table *, st_data_t, st_data_t);
  int st_lookup (st_table *, st_data_t, st_data_t *);
  int st_foreach (st_table *, int (*)(), st_data_t);
  void st_add_direct (st_table *, st_data_t, st_data_t);
  void st_free_table (st_table *);
  void st_cleanup_safe (st_table *, st_data_t);
  st_table *st_copy (st_table *);
  int st_strhash();
  alias int(*temp_func)();
  temp_func ST_NUMCMP = cast(temp_func)0;
  temp_func ST_NUMHASH = cast(temp_func)-2;
  temp_func st_numcmp = cast(temp_func)0;
  temp_func st_numhash = cast(temp_func)-2;
  /*  temp_func st_numcmp = ST_NUMCMP;
  temp_func st_numhash = st_numhash; */
}

int st_is_member(st_table *table, st_data_t key){
  return st_lookup(table,key,null);
}
