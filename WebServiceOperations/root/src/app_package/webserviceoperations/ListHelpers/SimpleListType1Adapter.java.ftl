package ${packageName}.webserviceoperations.ListHelpers;

import android.content.Context;
import android.graphics.Bitmap;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.util.Collections;
import java.util.List;

import com.bumptech.glide.Glide;
import com.bumptech.glide.request.animation.GlideAnimation;
import com.bumptech.glide.request.target.SimpleTarget;
<#if applicationPackage??>
import ${applicationPackage}.R;
</#if>

import ${packageName}.webserviceoperations.WebServiceHelpers.HeroDTO;

/**
 * Created by CHANDRASAIMOHAN on 8/20/2016.
 */
public class SimpleListType1Adapter extends RecyclerView.Adapter<SimpleListType1Adapter.SimpleType1ViewHolder> {


    List<HeroDTO> simpleDTOTypeList = Collections.EMPTY_LIST;
    private LayoutInflater inflator;
    Context context;

    public SimpleListType1Adapter(Context context, List<HeroDTO> data) {
        inflator = LayoutInflater.from(context);
        this.context  = context;
        simpleDTOTypeList = data;
    }

    @Override
    public SimpleType1ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = inflator.inflate(R.layout.simple_row_type1_webservice, parent, false);
        SimpleType1ViewHolder simpleType1ViewHolder = new SimpleType1ViewHolder(view);
        return simpleType1ViewHolder;
    }

    @Override
    public void onBindViewHolder(final  SimpleType1ViewHolder holder, int position) {
        HeroDTO simpleDTOType1 = simpleDTOTypeList.get(position);
        holder.title.setText(simpleDTOType1.getName());
        //holder.title_icon.setImageResource(simpleDTOType1.iconId);
        Glide.with(context)
                .load(simpleDTOType1.getImageURL())
                .asBitmap()
                .into(new SimpleTarget<Bitmap>() {
                    @Override
                    public void onResourceReady(Bitmap resource, GlideAnimation<? super Bitmap> glideAnimation) {
                        holder.title_icon.setImageBitmap(resource);
                    }
                });
    }


    private void delete(int position) {
        simpleDTOTypeList.remove(position);
        notifyItemRemoved(position);
    }



    @Override
    public int getItemCount() {
        return simpleDTOTypeList.size();
    }

    class SimpleType1ViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {
        TextView title;
        ImageView title_icon;
        LinearLayout rootLayout;

        public SimpleType1ViewHolder(View itemView) {
            super(itemView);
            title = (TextView) itemView.findViewById(R.id.simple_type1_title);
            title_icon = (ImageView) itemView.findViewById(R.id.simple_type1_image);
            rootLayout = (LinearLayout) itemView.findViewById(R.id.root_layout);
            // rootLayout.setOnClickListener(this);
            title.setOnClickListener(this);

        }

        @Override
        public void onClick(View v) {
            rootLayout.setSelected(false);
            switch (v.getId()) {
                  case R.id.root_layout:
                    rootLayout.setSelected(true);
                    break;
            }


        }
    }
}
