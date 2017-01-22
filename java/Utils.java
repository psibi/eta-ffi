package eta.examples;

import java.util.Date;
import java.util.Calendar;
import java.util.TimeZone;
import java.text.SimpleDateFormat;

public class Utils {
    
    public static long getClockTimePrim() {
        Date date = new Date();
        return date.getTime();
    }

    public static String getTZ(Calendar cal) {
        return cal.getTimeZone().getDisplayName();
    }

    public static Calendar getTimeInUTC(long millis) {
        Calendar cal = Calendar.getInstance();
        cal.setTimeInMillis(millis);
        cal.setTimeZone(TimeZone.getTimeZone("UTC"));
        return cal;
    }
    
    public static String[] getNames() {
        String[] names = {"sibi", "alex", "rahul"};
        return names;
    }
    
    public static long[] someLongExample() {
        long[] x = {1L, 2L, 3L};
        return x;
    }

    public static long[] someLongExample2(long[] y) {
        return y;
    }
    
}
