function [ noisy_image,smoothed_image ] = main_smoothfilters( image,noise_type,noise_parameters,filtering_domain,smoothing_type,filter_parameters )
	%Initialize parameters for function
    %Reads the Image

    noisy_image = add_noise(image,noise_type,noise_parameters);

    if strcmp(filtering_domain,'spatial')
        smoothed_image = spatial_domain_filtering(noisy_image,smoothing_type,filter_parameters);
    elseif strcmp(filtering_domain,'frequency')
        smoothed_image = frequency_domain_filtering(noisy_image,smoothing_type,filter_parameters);
    end

end

