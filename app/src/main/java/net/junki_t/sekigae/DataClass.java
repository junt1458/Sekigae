package net.junki_t.sekigae;

import android.content.Context;
import android.content.SharedPreferences;

import java.util.HashSet;

/**
 * Created by tomatsujunki on 16/07/03.
 */
public class DataClass {
    public static int man = 0;
    public static int woman = 0;
    public static int maxcount = 0;
    public final static int CountLimit = 48;
    public static boolean[] sekistatus;
    public static boolean[] m_wstatus;
    public static PeopleInformation[] People_Data;
    public static int[] Seat_Data;
    public static boolean rotateLabel = true;
    public static boolean colorLabel = true;
    public static int[] Before_Data;

    public static void saveData(){
        SharedPreferences sp = MainActivity.instance.getSharedPreferences("Sekigae_Data", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sp.edit();
        editor.putInt("man", man);
        editor.putInt("woman", woman);
        editor.putInt("maxcount", maxcount);
        editor.putStringSet("sekistatus", convertToStringList(sekistatus));
        editor.putStringSet("m_wstatus", convertToStringList(m_wstatus));
        editor.putStringSet("People_Data", convertToStringList(People_Data));
        editor.putBoolean("rotateLabel", rotateLabel);
        editor.putBoolean("colorLabel", colorLabel);
        editor.putStringSet("Before_Data", convertToStringList(Before_Data));
        editor.commit();
    }

    public static void loadData(){
        SharedPreferences sp = MainActivity.instance.getSharedPreferences("Sekigae_Data", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sp.edit();
        if(sp.getInt("man", -1) == -1){
            editor.putInt("man", 0);
        }
        if(sp.getInt("woman", -1) == -1){
            editor.putInt("woman", 0);
        }
        if(sp.getInt("maxcount", -1) == -1){
            editor.putInt("maxcount", 0);
        }
        if(!sp.contains("rotateLabel")){
            editor.putBoolean("rotateLabel", true);
        }
        if(!sp.contains("colorLabel")){
            editor.putBoolean("colorLabel", true);
        }
        if(sp.getStringSet("Before_Data", null) == null) {
            editor.putStringSet("Before_Data", convertToStringList(getBefore_Data()));
        }
        editor.commit();
        man = sp.getInt("man", 0);
        woman = sp.getInt("woman", 0);
        maxcount = sp.getInt("maxcount", 0);
        if(sp.contains("sekistatus")) {
            sekistatus = convertToBooleanList((HashSet) sp.getStringSet("sekistatus", null));
        }
        if(sp.contains("m_wstatus")) {
            m_wstatus = convertToBooleanList((HashSet) sp.getStringSet("m_wstatus", null));
        }
        if(sp.contains("People_Data")){
            People_Data = convertToPeopleList((HashSet) sp.getStringSet("People_Data", null));
        }
        rotateLabel = sp.getBoolean("rotateLabel", true);
        colorLabel = sp.getBoolean("colorLabel", true);
        Before_Data = convertToIntList((HashSet) sp.getStringSet("Before_Data", null));
    }

    public static void formatTempData(){
        man = 0;
        woman = 0;
        maxcount = 0;
        sekistatus = null;
        m_wstatus = null;
        People_Data = null;
        Seat_Data = null;
        rotateLabel = true;
        colorLabel = true;
        Before_Data = null;
    }

    public static void formatData(){
        formatTempData();
        SharedPreferences sp = MainActivity.instance.getSharedPreferences("Sekigae_Data", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sp.edit();
        editor.putInt("man", man);
        editor.putInt("woman", woman);
        editor.putInt("maxcount", maxcount);
        editor.remove("sekistatus");
        editor.remove("m_wstatus");
        editor.remove("People_Data");
        editor.putBoolean("rotateLabel", rotateLabel);
        editor.putBoolean("colorLabel", colorLabel);
        editor.putStringSet("Before_Data", convertToStringList(getBefore_Data()));
        editor.commit();
    }

    public static void loadBefore(){
        SharedPreferences sp = MainActivity.instance.getSharedPreferences("Sekigae_Data", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sp.edit();
        if(sp.getStringSet("Before_Data", null) == null) {
            editor.putStringSet("Before_Data", convertToStringList(getBefore_Data()));
        }
        editor.commit();
        Before_Data = convertToIntList((HashSet) sp.getStringSet("Before_Data", null));
    }

    public static PeopleInformation[] convertToPeopleList(HashSet<String> set){
        PeopleInformation[] PD = new PeopleInformation[set.size()];
        for(String str : set){
            String[] list = str.split("§dad§");
            int index = Integer.parseInt(list[0]);
            int AllNumber = Integer.parseInt(list[1]);
            boolean isMan = Boolean.parseBoolean(list[2]);
            String Name = list[3];
            int Number = Integer.parseInt(list[4]);
            PeopleInformation pi = new PeopleInformation(isMan, -1, Name, Number, AllNumber);
            PD[index] = pi;
        }
        return PD;
    }

    public static int[] convertToIntList(HashSet<String> set){
        int[] DT = new int[set.size()];
        for(String str : set){
            String[] list = str.split("_");
            int index = Integer.parseInt(list[0]);
            int value = Integer.parseInt(list[1]);
            DT[index] = value;
        }
        return DT;
    }

    public static boolean[] convertToBooleanList(HashSet<String> set){
        boolean[] DT = new boolean[set.size()];
        for(String str : set){
            String[] list = str.split("_");
            int index = Integer.parseInt(list[0]);
            boolean value = Boolean.parseBoolean(list[1]);
            DT[index] = value;
        }
        return DT;
    }

    public static HashSet<String> convertToStringList(PeopleInformation[] list){
        HashSet<String> str = new HashSet<>();
        for(int c = 0; c < list.length; c++){
            PeopleInformation d = list[c];
            str.add(c + "§dad§" + d.AllNumber + "§dad§" + d.isMan + "§dad§" + d.Name + "§dad§" + d.Number);
        }
        return str;
    }

    public static HashSet<String> convertToStringList(int[] list){
        HashSet<String> str = new HashSet<>();
        for(int c = 0; c < list.length; c++){
            str.add(c + "_" + list[c]);
        }
        return str;
    }

    public static HashSet<String> convertToStringList(boolean[] list){
        HashSet<String> str = new HashSet<>();
        for(int c = 0; c < list.length; c++){
            str.add(c + "_" + list[c]);
        }
        return str;
    }

    public static int[] getBefore_Data(){
        int[] bBefore_Data = new int[CountLimit];
        for(int i = 0; i < CountLimit; i++){
            bBefore_Data[i] = -1;
        }
        return bBefore_Data;
    }
}
