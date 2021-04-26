package com.example.piggy_android.fragments;

import android.content.Intent;
import android.os.Bundle;

import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;

import com.example.piggy_android.GroupCreateActivity;
import com.example.piggy_android.R;

public class GroupFragment extends Fragment {

    Button addNewGroupBtn;

    public GroupFragment() {
        // Required empty public constructor
    }


    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_group, container, false);

        addNewGroupBtn = view.findViewById(R.id.addNewGroup);

        addNewGroupBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getActivity(), GroupCreateActivity.class);
                startActivity(intent);
            }
        });
        // Inflate the layout for this fragment
        return view;




    }
}