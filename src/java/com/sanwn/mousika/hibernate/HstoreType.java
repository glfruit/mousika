package com.sanwn.mousika.hibernate;

import org.hibernate.HibernateException;
import org.hibernate.usertype.UserType;

import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.HashMap;
import java.util.Map;

/**
 * @author glix
 * @version 1.0
 */
public class HstoreType implements UserType {

    @Override
    public int[] sqlTypes() {
        return new int[]{Types.INTEGER};
    }

    @Override
    public Class returnedClass() {
        return Map.class;
    }

    @Override
    public boolean equals(Object o, Object o2) throws HibernateException {
        Map m1 = (Map) o;
        Map m2 = (Map) o2;
        return m1.equals(m2);
    }

    @Override
    public int hashCode(Object o) throws HibernateException {
        return o.hashCode();
    }

    @Override
    public Object nullSafeGet(ResultSet rs, String[] args, Object o) throws HibernateException, SQLException {
        String col = args[0];
        String val = rs.getString(col);
        return HstoreHelper.toMap(val);
    }

    @Override
    public void nullSafeSet(PreparedStatement ps, Object o, int i) throws HibernateException, SQLException {
        String s = HstoreHelper.toString((Map<String, String>) o);
        ps.setObject(i, s, Types.OTHER);
    }

    @Override
    public Object deepCopy(Object o) throws HibernateException {
        // It's not a true deep copy, but we store only String instances, and they
        // are immutable, so it should be OK
        Map m = (Map) o;
        return new HashMap(m);
    }

    @Override
    public boolean isMutable() {
        return true;
    }

    @Override
    public Serializable disassemble(Object o) throws HibernateException {
        return (Serializable) o;
    }

    @Override
    public Object assemble(Serializable cached, Object owner) throws HibernateException {
        return cached;
    }

    @Override
    public Object replace(Object original, Object target, Object owner) throws HibernateException {
        return original;
    }
}
