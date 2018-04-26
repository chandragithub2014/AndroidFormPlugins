package ${packageName}.sqliteoperations.Retrieve;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.util.Collections;
import java.util.List;

<#if applicationPackage??>
import ${applicationPackage}.R;
</#if>


import  ${packageName}.sqliteoperations.Interfaces.ClickListener;


/**
 * Created by CHANDRASAIMOHAN on 8/20/2016.
 */
public class SimpleListType1Adapter extends RecyclerView.Adapter<SimpleListType1Adapter.SimpleType1ViewHolder> {


    List<SimpleDTOType1> simpleDTOTypeList = Collections.EMPTY_LIST;
    private LayoutInflater inflator;
    ClickListener clickListener;

    public SimpleListType1Adapter(Context context, List<SimpleDTOType1> data, ClickListener clickListener) {
        inflator = LayoutInflater.from(context);
        simpleDTOTypeList = data;
        this.clickListener = clickListener;
    }

    @Override
    public SimpleType1ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = inflator.inflate(R.layout.simple_row_type1, parent, false);
        SimpleType1ViewHolder simpleType1ViewHolder = new SimpleType1ViewHolder(view);
        return simpleType1ViewHolder;
    }

    @Override
    public void onBindViewHolder(SimpleType1ViewHolder holder, int position) {
        SimpleDTOType1 simpleDTOType1 = simpleDTOTypeList.get(position);
        holder.title.setText(simpleDTOType1.title);
        holder.title_icon.setImageResource(simpleDTOType1.iconId);
        holder.ic_edit.setTag(simpleDTOType1.rowId);

    }


    private void delete(int position) {
        simpleDTOTypeList.remove(position);
        notifyItemRemoved(position);
    }

    public void add() {
        int size = simpleDTOTypeList.size();

        int nextPosition = 1;
        SimpleDTOType1 addItem = new SimpleDTOType1();
        addItem.iconId = R.drawable.ic_india_flag;
        addItem.title = "NewIndia" + (size + 1);
        simpleDTOTypeList.add(1, addItem);
        notifyItemInserted(nextPosition);
        //not
    }

    @Override
    public int getItemCount() {
        return simpleDTOTypeList.size();
    }

    class SimpleType1ViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {
        TextView title;
        ImageView title_icon;
        ImageView ic_edit;
        LinearLayout rootLayout;

        public SimpleType1ViewHolder(View itemView) {
            super(itemView);
            title = (TextView) itemView.findViewById(R.id.simple_type1_title);
            title_icon = (ImageView) itemView.findViewById(R.id.simple_type1_image);
            ic_edit = (ImageView) itemView.findViewById(R.id.edit_row);
            rootLayout = (LinearLayout) itemView.findViewById(R.id.root_layout);
            ic_edit.setOnClickListener(this);
            title.setOnClickListener(this);

        }

        @Override
        public void onClick(View v) {
            rootLayout.setSelected(false);
            switch (v.getId()) {
                case R.id.simple_type1_title:
                    delete(getAdapterPosition());
                    break;
                case R.id.root_layout:
                    rootLayout.setSelected(true);
                    break;
                case R.id.edit_row:
                    Log.d("Adapter","Edit Icon Clicked"+ic_edit.getTag().toString());
                    clickListener.onClick("_id",ic_edit.getTag().toString());
                    break;
            }


        }
    }
}
