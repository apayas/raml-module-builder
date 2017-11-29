  <#-- Create / Drop btree indexes -->
  <#if table.index??>
    <#list table.index as indexes>
    <#if indexes.tOps.name() == "ADD">
    CREATE INDEX IF NOT EXISTS ${table.tableName}_${indexes.fieldName}_idx ON ${myuniversity}_${mymodule}.${table.tableName}
    (
      <#if indexes.caseSensitive == false>lower</#if>
        (
          <#if indexes.removeAccents == true>f_unaccent(</#if>
            ${indexes.fieldPath}
          <#if indexes.removeAccents == true>)</#if>
        )
     )
     <#if indexes.whereClause??> ${indexes.whereClause};<#else>;</#if>
    <#else>
    DROP INDEX IF EXISTS ${table.tableName}_${indexes.fieldName}_idx;
    </#if>
    </#list>
  </#if>

  <#-- Create / Drop unique indexes -->
  <#if table.uniqueIndex??>
    <#list table.uniqueIndex as indexes>
    <#if indexes.tOps.name() == "ADD">
    CREATE UNIQUE INDEX IF NOT EXISTS ${table.tableName}_${indexes.fieldName}_idx_unique ON ${myuniversity}_${mymodule}.${table.tableName}
    (
      <#if indexes.caseSensitive == false>lower</#if>
        (
          <#if indexes.removeAccents == true>f_unaccent(</#if>
            ${indexes.fieldPath}
          <#if indexes.removeAccents == true>)</#if>
        )
     )
     <#if indexes.whereClause??> ${indexes.whereClause};<#else>;</#if>
    <#else>
    DROP INDEX IF EXISTS ${table.tableName}_${indexes.fieldName}_idx_unique;
    </#if>
    </#list>
  </#if>

  <#-- Create / Drop indexes for fuzzy LIKE matching -->
  <#if table.likeIndex??>
    <#list table.likeIndex as indexes>
      <#if indexes.tOps.name() == "ADD">
    CREATE INDEX IF NOT EXISTS ${table.tableName}_${indexes.fieldName}_idx_like ON ${myuniversity}_${mymodule}.${table.tableName}
    (
      <#if indexes.caseSensitive == false>lower</#if>
        (
          <#if indexes.removeAccents == true>f_unaccent(</#if>
            ${indexes.fieldPath}
          <#if indexes.removeAccents == true>)</#if>
        )
    text_pattern_ops)
    <#if indexes.whereClause??> ${indexes.whereClause};<#else>;</#if>
    <#else>
    DROP INDEX IF EXISTS ${table.tableName}_${indexes.fieldName}_idx_like;
    </#if>
    </#list>
  </#if>

  <#if table.ginIndex??>
    <#list table.ginIndex as indexes>
      <#if indexes.tOps.name() == "ADD">
    CREATE INDEX IF NOT EXISTS ${table.tableName}_${indexes.fieldName}_idx_gin ON ${myuniversity}_${mymodule}.${table.tableName} USING GIN
        (
      <#if indexes.caseSensitive == false>lower</#if>
        (
          <#if indexes.removeAccents == true>f_unaccent(</#if>
            ${indexes.fieldPath}
          <#if indexes.removeAccents == true>)</#if>
        )
    gin_trgm_ops)
    <#if indexes.whereClause??> ${indexes.whereClause};<#else>;</#if>
      <#else>
    DROP INDEX IF EXISTS ${table.tableName}_idx_gin;
      </#if>
    </#list>
  </#if>
