package ${packageName}.webserviceoperations.WebServiceHelpers;

import android.os.Parcel;
import android.os.Parcelable;

/**
 * Created by 245742 on 11/22/2017.
 */

public class HeroDTO implements Parcelable{
    private String name;
    private String imageURL;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public HeroDTO() {
    }

    public HeroDTO(Parcel in) {
        name = in.readString();
        imageURL = in.readString();

    }

    @Override
    public String toString() {
        return name + "\n" + imageURL;
    }


    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeString(name);
        dest.writeString(imageURL);
    }

    @SuppressWarnings("rawtypes")
    public static final Parcelable.Creator CREATOR = new Parcelable.Creator() {
        public HeroDTO createFromParcel(Parcel in) {
            return new HeroDTO(in);
        }

        public HeroDTO[] newArray(int size) {
            return new HeroDTO[size];
        }
    };
}
