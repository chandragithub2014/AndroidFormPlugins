package ${packageName}.sqliteoperations.DTO;

/**
 * Created by 245742 on 11/3/2017.
 */

public class ColumnDTO {
    private String columnName;
    private String columnType;

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getColumnType() {
        return columnType;
    }

    public void setColumnType(String columnType) {
        this.columnType = columnType;
    }
}
