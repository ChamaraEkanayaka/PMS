/*
 * Copyright (c) 2020  APK HUB Software Solution (Pvt.) Ltd
 * All rights reserved.
 * 03 Jan 2021 08:15:23 PM By AKILA.
 */
package DataHolders;

/**
 *
 * @author AKILA
 */
public class USER_LOGIN_DATA {

    int User_id, Branch_id;
    String Username, Name, BranchName;

    public int getUser_id() {
        return User_id;
    }

    public void setUser_id(int User_id) {
        this.User_id = User_id;
    }

    public int getBranch_id() {
        return Branch_id;
    }

    public void setBranch_id(int Branch_id) {
        this.Branch_id = Branch_id;
    }

    public String getUsername() {
        return Username;
    }

    public void setUsername(String Username) {
        this.Username = Username;
    }

    public String getName() {
        return Name;
    }

    public void setName(String Name) {
        this.Name = Name;
    }

    public String getBranchName() {
        return BranchName;
    }

    public void setBranchName(String BranchName) {
        this.BranchName = BranchName;
    }

}
