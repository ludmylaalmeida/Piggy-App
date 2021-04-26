package com.example.piggy_android;

import android.view.LayoutInflater;
import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

//import com.google.firebase.database.core.Context;
//import com.google.firebase.database.core.view.View;
import com.squareup.picasso.Picasso;

import java.util.List;

public class AdapterUsers extends RecyclerView.Adapter<AdapterUsers.MyHolder> {

    Context context;
    List<ModelUser> userList;

    // constructor

    // view holder class
    public class MyHolder extends RecyclerView.ViewHolder {

        ImageView profileImage;
        TextView nameTextView, usernameTextView;

        public MyHolder(@NonNull View itemView) {
            super(itemView);

            profileImage = itemView.findViewById(R.id.profileImage);
            nameTextView = itemView.findViewById(R.id.nameTextView);
            usernameTextView = itemView.findViewById(R.id.chatUserNameTextView);


        }

    }

    public AdapterUsers(Context context, List<ModelUser> userList) {
        this.context = context;
        this.userList = userList;
    }

    @NonNull
    @Override
    public MyHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        // inflate layout(row_user.xml)
        android.view.View view = LayoutInflater.from(context).inflate(R.layout.row_users, parent, false);



        return new MyHolder(view);
    }


    @Override
    public void onBindViewHolder(@NonNull MyHolder holder, int position) {
        // get data
        String userImage = userList.get(position).getImage();
        String userFirstName = userList.get(position).getFirstName();
        String userLastName = userList.get(position).getLastName();
        String userName = userList.get(position).getUsername();

        // set data
        holder.nameTextView.setText(userFirstName + " " + userLastName);
        holder.usernameTextView.setText(userName);
        try {
            Picasso.get().load(userImage).placeholder(R.drawable.user_circle_profile).into(holder.profileImage);
        } catch( Exception e) {

        }

        // handle item click
        holder.itemView.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                Toast.makeText(context, ""+ userName, Toast.LENGTH_SHORT).show();
            }
        });
            

        }


    @Override
    public int getItemCount() {
        return userList.size();
    }

}
